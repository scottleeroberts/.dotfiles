#!/bin/sh

session="work"

# detach from a tmux session if in one
tmux detach > /dev/null ^ /dev/null

# set up tmux
tmux start-server

# create a new tmux session, starting vim from a saved session in the new window
tmux new-session -d -s $session
tmux rename-window "     "
tmux send-keys "cd ~/Development/baldwin-web" C-m
tmux send-keys "vim" C-m

tmux new-window -t $session -n "     "
tmux rename-window "server"
tmux send-keys "cd ~/Development/baldwin-web" C-m

# create a new window
tmux new-window -t $session -n "     "
tmux rename-window "zsh"
tmux send-keys "cd ~/Development/baldwin-web" C-m
tmux send-keys "pactl load-module module-dbus-protocol" C-m
tmux send-keys "pactl load-module module-equalizer-sink " C-m
tmux send-keys "clear" C-m

# create a new window
tmux new-window -t $session -n "     "
tmux send-keys "cd ~/Development/baldwin-web" C-m
tmux send-keys "weechat" C-m

# return to main vim window
tmux select-window -t $session:1

# Finished setup, attach to the tmux session!
tmux attach-session -t $session
