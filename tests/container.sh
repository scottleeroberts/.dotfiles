#!/usr/bin/env bash
set -euo pipefail
root=$(cd -- "$(dirname -- "$0")/.." && pwd)
case ${1:-all} in
  ubuntu) images=(ubuntu:24.04) ;;
  arch) images=(archlinux:latest) ;;
  all) images=(ubuntu:24.04 archlinux:latest) ;;
  *) echo 'Usage: tests/container.sh [ubuntu|arch|all]' >&2; exit 2 ;;
esac
for image in "${images[@]}"; do
  echo "Testing $image"
  # Send the current contents of tracked config files and the installer/test
  # scripts. The container gets no host mounts, home directory or Git metadata.
  {
    git -C "$root" ls-files -z -- alacritty bin dunst fonts gem git i3 ignore neovim picom readline rofi tmate tmux urlview xmodmap zsh
    printf '%s\0' setup-ubuntu.sh setup-arch.sh stow_all setup/{install.sh,neovim.sh,neovim.lua} tests/{verify.sh,container-entry.sh}
  } | tar -C "$root" --null -T - -cf - | docker run --rm -i "$image" bash -euc '
    mkdir /dotfiles
    tar -xf - -C /dotfiles
    exec bash /dotfiles/tests/container-entry.sh
  '
done
