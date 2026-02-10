#!/bin/bash
# Snap package installation

echo "Installing Snap packages..."

# Ensure snapd is installed and running
sudo apt install -y snapd
sudo systemctl enable --now snapd.socket

# Install packages
sudo snap install alacritty --classic

echo "Snap packages installed successfully"
