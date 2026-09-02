#!/bin/sh

set -eu

session="work"
rails_dir="$HOME/prizepicks/prizepicks-rails"
devenv_dir="$HOME/prizepicks/prizepicks-devenv"
dotfiles_dir="$HOME/.dotfiles"

attach_session() {
  if [ -n "${TMUX:-}" ]; then
    exec tmux switch-client -t "=$session"
  fi

  exec tmux attach-session -t "=$session"
}

if tmux has-session -t "=$session" 2>/dev/null; then
  attach_session
fi

tmux new-session -d -s "$session" -n rails -c "$rails_dir"
tmux send-keys -t "$session:rails" vim C-m

tmux new-window -d -t "$session:" -n devenv -c "$devenv_dir"
tmux new-window -d -t "$session:" -n dotfiles -c "$dotfiles_dir"

attach_session
