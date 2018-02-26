#!/bin/sh
#
# Setup a work space called `work` with two windows
# first window has 3 panes.
# The first pane set at 65%, split horizontally, set to api root and running vim
# pane 2 is split at 25% and running redis-server
# pane 3 is set to api root and bash prompt.
# note: `api` aliased to `cd ~/path/to/work`
#
session="work"

# detach from a tmux session if in one
tmux detach > /dev/null ^ /dev/null

# set up tmux
tmux start-server

# create a new tmux session, starting vim from a saved session in the new window
tmux new-session -d -s $session
tmux send-keys "cd ~/Development/baldwin-web" C-m
tmux send-keys "vim" C-m

tmux new-window -t $session -n server
tmux send-keys "cd ~/Development/baldwin-web" C-m

# create a new window
tmux new-window -t $session -n zsh
tmux send-keys "cd ~/Development/baldwin-web" C-m
tmux send-keys "xrandr --output eDP1 --mode 1920x1200" C-m
tmux send-keys "pactl load-module module-dbus-protocol" C-m
tmux send-keys "pactl load-module module-equalizer-sink " C-m

# create a new window
tmux new-window -t $session -n weechat
tmux send-keys "cd ~/Development/baldwin-web" C-m
tmux send-keys "weechat" C-m

# return to main vim window
tmux select-window -t $session:1

# Finished setup, attach to the tmux session!
tmux attach-session -t $session
