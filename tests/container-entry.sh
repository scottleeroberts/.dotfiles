#!/usr/bin/env bash
set -euo pipefail
. /etc/os-release
case "$ID" in
  ubuntu)
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y sudo stow
    entry=setup-ubuntu.sh
    ;;
  arch)
    sed -i -E "s/^[#[:space:]]*ParallelDownloads[[:space:]]*=.*/ParallelDownloads = 8/" /etc/pacman.conf
    pacman -Syu --noconfirm --needed sudo stow
    entry=setup-arch.sh
    ;;
esac
useradd -m -s /bin/bash tester
echo 'tester ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/tester
chmod 440 /etc/sudoers.d/tester
# Place the checkout somewhere other than ~/.dotfiles so path assumptions fail.
mv /dotfiles /home/tester/config-source
chown -R tester:tester /home/tester/config-source
cd /home/tester
sudo -H -u tester bash -euc '
  cd "$HOME/config-source"
  printf "%s\n" --adopt > "$HOME/.stowrc"
  printf "original\n" > "$HOME/.zshrc"
  if "./$1" --no-plugins > /tmp/stow-conflict.log 2>&1; then
    echo "Installer accepted a conflicting .zshrc" >&2
    exit 1
  fi
  grep -q "Stow found existing config" /tmp/stow-conflict.log
  test "$(cat "$HOME/.zshrc")" = original
  test ! -e "$HOME/.tmux.conf"
  rm -- "$HOME/.zshrc" "$HOME/.stowrc"
  "./$1"
  test ! -e "$HOME/.config/i3/config"
  ./tests/verify.sh
  "./$1" --desktop
  "./$1" --desktop
  ./tests/verify.sh --desktop
' bash "$entry"
