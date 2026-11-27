#!/usr/bin/env bash
set -Eeuo pipefail
root=$(cd -- "$(dirname -- "$0")/.." && pwd)
export PATH="$HOME/.local/bin:$PATH"
export DOTFILES_NO_AUTOTMUX=1
for cmd in git stow zsh tmux fzf rg nvim mise node npm python3 cc script; do
  command -v "$cmd" >/dev/null || { echo "Missing: $cmd" >&2; exit 1; }
done
[[ $(realpath "$HOME/.config/mise/config.toml") == "$root/mise/.config/mise/config.toml" ]]
mise exec -- ruby --version
mise exec -- tree-sitter --version
[[ $(realpath "$HOME/.zshrc") == "$root/zsh/.zshrc" ]]
[[ $(realpath "$HOME/.config/nvim/init.lua") == "$root/neovim/.config/nvim/init.lua" ]]
zsh -n "$HOME/.zshrc"
# fzf's current shell integration expects a functioning Zsh line editor.
export DOTFILES_ZSH_CHECK='
  [[ -n $DOTFILES && $(whence -p git-up) == "$DOTFILES/bin/git-up" ]] &&
  (( $+functions[_zsh_highlight] && $+widgets[fzf-file-widget] ))
'
if ! zsh_output=$(TERM=xterm-256color timeout 15 script -qec 'zsh -lic "$DOTFILES_ZSH_CHECK"' /dev/null 2>&1) ||
   [[ -n $zsh_output ]]; then
  printf 'Zsh startup or widget check failed:\n%s\n' "$zsh_output" >&2
  exit 1
fi

socket="dotfiles-test-$$"
unset TMUX
trap 'tmux -L "$socket" kill-server 2>/dev/null || true' EXIT
tmux -L "$socket" -f "$HOME/.tmux.conf" new-session -d -s verify
tmux -L "$socket" source-file "$HOME/.tmux.conf"
[[ $(tmux -L "$socket" show-option -gv prefix) == C-Space ]]
[[ $(tmux -L "$socket" show-option -gv default-shell) == /usr/bin/zsh ]]
tmux -L "$socket" split-window -t verify
[[ $(tmux -L "$socket" list-panes -t verify -F '#{pane_id}' | wc -l) -eq 2 ]]

if [[ ${1:-} == --desktop ]]; then
  for cmd in i3 i3blocks alacritty rofi picom dunst; do command -v "$cmd" >/dev/null; done
  [[ $(realpath "$HOME/.xprofile") == "$root/xprofile/.xprofile" ]]
  i3 -C -c "$HOME/.config/i3/config"
  fc-list --format='%{family}\n' | awk '/Lilex Nerd Font Mono/ { found=1 } END { exit !found }'
fi
"$root/setup/neovim.sh" verify
echo 'Shell, tmux, Neovim and symlink checks passed.'
