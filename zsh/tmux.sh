#!/bin/sh

session="work"

# detach from a tmux session if in one
tmux detach > /dev/null ^ /dev/null

# set up tmux
tmux start-server

# create a new tmux session, starting vim from a saved session in the new window
tmux new-session -d -s $session

tmux new-window -t $session
tmux send-keys -t $session:1 "cd ~/Development/prizepicks-rails" C-m
tmux send-keys -t $session:1 "vim" C-m

tmux new-window -t $session
tmux send-keys -t $session:2 "cd ~/Development/prizepicks-devenv" C-m

tmux new-window -t $session
tmux send-keys -t $session:3 "cd ~/.dotfiles" C-m

# return to main vim window
tmux select-window -t $session:1

# Finished setup, attach to the tmux session!
tmux attach-session -t $session
