#!/usr/bin/env bash
set -euo pipefail
root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
case ${1:-} in
  install|verify) ;;
  *) echo 'Usage: setup/neovim.sh install|verify' >&2; exit 2 ;;
esac
export PATH="$HOME/.local/bin:$PATH"
export DOTFILES_NVIM_EXPECTED_LOCKFILE="$root/neovim/.config/nvim/lazy-lock.json"
export DOTFILES_NVIM_CHECK="$root/setup/neovim.lua"
temp=$(mktemp -d)
trap 'rm -rf -- "$temp"' EXIT
export DOTFILES_NVIM_LOCKFILE="$temp/lazy-lock.json"
log="$temp/neovim.log"
if [[ $1 == install ]]; then
  # ts-install invokes curl directly. Retry transient release archive errors.
  export CURL_HOME="$temp"
  printf '%s\n' 'retry = 3' 'connect-timeout = 10' 'speed-time = 20' 'speed-limit = 512' > "$temp/.curlrc"
fi
# Lazy can write its lockfile during first boot. Give it a temporary copy.
cp "$DOTFILES_NVIM_EXPECTED_LOCKFILE" "$DOTFILES_NVIM_LOCKFILE"
run_check() {
  export DOTFILES_NVIM_MODE=$1
  if ! timeout 300 mise exec -- nvim --headless -i NONE -c 'lua dofile(vim.env.DOTFILES_NVIM_CHECK)' > "$log" 2>&1 ||
     grep -Eq 'Error detected|E[0-9]{2,}:|Failed to (run|load)' "$log"; then
    cat "$log" >&2
    return 1
  fi
  echo "Neovim $1 passed."
}
run_check "$1"
if [[ $1 == install ]]; then
  run_check verify
fi
