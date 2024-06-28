#!/bin/sh

session="work"

# detach from a tmux session if in one
tmux detach > /dev/null ^ /dev/null

# set up tmux
tmux start-server

# create a new tmux session, starting vim from a saved session in the new window
tmux new-session -d -s $session
# tmux rename-window " NVIM "
tmux send-keys "cd ~/Development/swoop/" C-m
tmux send-keys "vim" C-m

tmux new-window -t $session
# tmux rename-window "Server"
tmux send-keys "cd ~/Development/swoop" C-m

# create a new window
tmux new-window -t $session
# tmux rename-window "Shell"
tmux send-keys "cd ~/Development/swoop" C-m
tmux send-keys "clear" C-m

# create a new window
# tmux new-window -t $session -n "     "
tmux send-keys "cd ~/Development/swoop" C-m

# return to main vim window
tmux select-window -t $session:1

# Finished setup, attach to the tmux session!
tmux attach-session -t $session
