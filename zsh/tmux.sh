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

enable_automatic_rename() {
  tmux list-windows -t "=$session" -F '#{window_id}' |
    while IFS= read -r window_id; do
      tmux set-window-option -t "$window_id" automatic-rename on
    done
}

if tmux has-session -t "=$session" 2>/dev/null; then
  enable_automatic_rename
  attach_session
fi

rails_window=$(tmux new-session -d -P -F '#{window_id}' -s "$session" -c "$rails_dir")
tmux send-keys -t "$rails_window" vim C-m

tmux new-window -d -t "$session:" -c "$devenv_dir"
tmux new-window -d -t "$session:" -c "$dotfiles_dir"

enable_automatic_rename
attach_session
