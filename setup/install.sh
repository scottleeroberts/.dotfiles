#!/usr/bin/env bash
set -Eeuo pipefail
root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
desktop=()
plugins=1
for arg in "$@"; do
  case "$arg" in
    --desktop) desktop=(--desktop) ;;
    --no-plugins) plugins=0 ;;
    -h|--help) echo 'Usage: setup/install.sh [--desktop] [--no-plugins]'; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 2 ;;
  esac
done
die() { printf '%s\n' "$*" >&2; exit 1; }
(( EUID != 0 )) || die 'Run as your normal user. The installer uses sudo for system packages.'
. /etc/os-release
case "${ID:-}" in
  ubuntu|arch) distro=$ID ;;
  *) die "Unsupported distribution: ${ID:-unknown}. Ubuntu 24.04 LTS and Arch Linux are the targets." ;;
esac
command -v sudo >/dev/null || die 'Install sudo and grant this user sudo access first.'

export PATH="$HOME/.local/bin:$PATH"
# Install only Stow if it is missing, so existing home config can be checked first.
if ! command -v stow >/dev/null && [[ $distro == ubuntu ]]; then
  sudo apt-get update
  sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y stow
fi
if command -v stow >/dev/null; then
  "$root/stow_all" --check --core "${desktop[@]}"
fi

common=(ca-certificates curl git stow zsh zsh-syntax-highlighting tmux ripgrep unzip xclip xsel tig btop ruby)
desktop_common=(i3blocks i3lock rofi dunst picom feh scrot arandr pavucontrol alacritty fontconfig brightnessctl dex gammastep blueman)
if [[ $distro == ubuntu ]]; then
  packages=(fd-find build-essential python3 python3-pynvim xz-utils openssh-client gh)
  if (( ${#desktop[@]} )); then
    packages+=("${desktop_common[@]}" i3 x11-xserver-utils pulseaudio-utils network-manager-gnome fonts-dejavu-core)
  fi
  sudo apt-get update
  sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends "${common[@]}" "${packages[@]}"
else
  packages=(fd fzf base-devel python python-pynvim nodejs npm openssh github-cli neovim tree-sitter-cli)
  if (( ${#desktop[@]} )); then
    packages+=("${desktop_common[@]}" i3-wm xorg-xrandr xorg-xmodmap libpulse network-manager-applet ttf-dejavu ttf-lilex-nerd)
  fi
  sudo pacman -Syu --needed --noconfirm "${common[@]}" "${packages[@]}"
fi
"$root/stow_all" --check --core "${desktop[@]}"

download() {
  curl --silent --show-error --fail --location --retry 3 --connect-timeout 20 --speed-time 30 --speed-limit 512 --max-time 300 "$1" -o "$2"
  printf '%s  %s\n' "$3" "$2" | sha256sum --check
}

# Keep Ubuntu's upstream tools in versioned user directories.
if [[ $distro == ubuntu ]]; then
  case $(uname -m) in
    x86_64)
      nvim_arch=x86_64
      fzf_arch=amd64
      fzf_sha=0d6640f83582d991cf429754baad64b07e3a4e439a6019670f4b91da1314141c
      ts_arch=x64
      nvim_sha=012bf3fcac5ade43914df3f174668bf64d05e049a4f032a388c027b1ebd78628
      node_sha=4f2b175a6d53a5c617a80dba2676238a0688cef28c6da4eba35c7d844e66fcfb
      ts_sha=9ce82137caa65864e7ca8b869fd391cef88c9bd2a01c4371b9c4dd26c2585efb
      ;;
    aarch64)
      nvim_arch=arm64
      fzf_arch=arm64
      fzf_sha=bd0717badb6a5620387e014bb94209aac4d9eab6ab77b5348eabb0833aeb4d59
      ts_arch=arm64
      nvim_sha=ceb7e88c6b681f0515d135dcdfad54f5eb4373b25ce6172197cd9a69c758063f
      node_sha=6e51a2ada00f0011cc266f65d98922b403d7ad88f809ca2aa615a5fe1ce6e86c
      ts_sha=c8feeb32115958cb44442ca4d68f6d66cf7605dbd65681e62342181ebdd6db3b
      ;;
    *) die "Unsupported Ubuntu architecture: $(uname -m)" ;;
  esac
  mkdir -p "$HOME/.local/bin" "$HOME/.local/opt"
  tmp=$(mktemp -d "$HOME/.local/opt/.setup.XXXXXX")
  trap 'rm -rf -- "$tmp"' EXIT
  nvim_version=0.12.4
  ts_version=0.26.9
  nvim_dir="$HOME/.local/opt/nvim-$nvim_version"
  ts_dir="$HOME/.local/opt/tree-sitter-$ts_version"
  fzf_version=0.75.0
  fzf_dir="$HOME/.local/opt/fzf-$fzf_version"
  node_version=24.22.3
  node_dist="node-v$node_version-linux-$ts_arch"
  node_dir="$HOME/.local/opt/$node_dist"
  declare -A links=(
    [nvim]="$nvim_dir/bin/nvim"
    [fzf]="$fzf_dir/fzf"
    [tree-sitter]="$ts_dir/tree-sitter"
    [node]="$node_dir/bin/node"
    [npm]="$node_dir/bin/npm"
    [npx]="$node_dir/bin/npx"
  )
  for name in "${!links[@]}"; do
    target=${links[$name]}
    link="$HOME/.local/bin/$name"
    if [[ -e $link || -L $link ]]; then
      [[ -L $link && $(readlink -- "$link") == "$target" ]] ||
        die "Existing $link belongs to another installation. Move it aside and rerun."
    fi
  done
  if [[ ! -x $nvim_dir/bin/nvim ]]; then
    download "https://github.com/neovim/neovim/releases/download/v$nvim_version/nvim-linux-$nvim_arch.tar.gz" "$tmp/nvim.tar.gz" "$nvim_sha"
    tar -xzf "$tmp/nvim.tar.gz" -C "$tmp"
    mv -T -- "$tmp/nvim-linux-$nvim_arch" "$nvim_dir"
  fi
  if [[ ! -x $ts_dir/tree-sitter ]]; then
    download "https://github.com/tree-sitter/tree-sitter/releases/download/v$ts_version/tree-sitter-linux-$ts_arch.gz" "$tmp/tree-sitter.gz" "$ts_sha"
    mkdir "$tmp/tree-sitter"
    gzip -dc -- "$tmp/tree-sitter.gz" > "$tmp/tree-sitter/tree-sitter"
    chmod +x "$tmp/tree-sitter/tree-sitter"
    mv -T -- "$tmp/tree-sitter" "$ts_dir"
  fi
  # Ubuntu's fzf package predates fzf --zsh and minimal images strip its
  # integration scripts because they are shipped under /usr/share/doc.
  if [[ ! -x $fzf_dir/fzf ]]; then
    download "https://github.com/junegunn/fzf/releases/download/v$fzf_version/fzf-$fzf_version-linux_$fzf_arch.tar.gz" "$tmp/fzf.tar.gz" "$fzf_sha"
    mkdir "$tmp/fzf"
    tar -xzf "$tmp/fzf.tar.gz" -C "$tmp/fzf"
    mv -T -- "$tmp/fzf" "$fzf_dir"
  fi
  if [[ ! -x $node_dir/bin/node ]]; then
    download "https://nodejs.org/dist/v$node_version/$node_dist.tar.xz" "$tmp/node.tar.xz" "$node_sha"
    tar -xJf "$tmp/node.tar.xz" -C "$tmp"
    mv -T -- "$tmp/$node_dist" "$node_dir"
  fi
  for name in "${!links[@]}"; do
    [[ -L $HOME/.local/bin/$name ]] || ln -s -- "${links[$name]}" "$HOME/.local/bin/$name"
  done
  if (( ${#desktop[@]} )) && [[ ! -e $HOME/.local/share/fonts/LilexNerdFontMono/LilexNerdFontMono-Regular.ttf ]]; then
    download 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/Lilex.zip' "$tmp/Lilex.zip" \
      07645c3a839fa8f74e8555c6c1c45187bf27d49fb27410992715f124311609e4
    unzip -q "$tmp/Lilex.zip" 'LilexNerdFontMono-*.ttf' -d "$tmp/LilexNerdFontMono"
    mkdir -p "$HOME/.local/share/fonts"
    mv -T -- "$tmp/LilexNerdFontMono" "$HOME/.local/share/fonts/LilexNerdFontMono"
  fi
fi

"$root/stow_all" --core "${desktop[@]}"
if (( ${#desktop[@]} )); then fc-cache -f; fi
if (( plugins )); then
  "$root/setup/neovim.sh" install
fi
echo 'Setup completed. Run tests/verify.sh to check your installation.'
echo 'To make Zsh your login shell, run: chsh -s "$(command -v zsh)"'
