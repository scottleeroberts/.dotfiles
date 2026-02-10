#!/bin/bash
# Version managers for Node, Neovim, etc.

echo "Setting up version managers..."

# Node.js (via NodeSource)
echo "Installing Node.js v24.x via NodeSource..."
if ! command -v node &> /dev/null; then
  curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
  sudo apt install -y nodejs
else
  echo "Node.js already installed"
fi

# Bob (Neovim version manager)
echo "Installing bob (Neovim version manager)..."
if ! command -v bob &> /dev/null; then
  # Install Rust (needed for bob)
  if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
  fi

  # Install bob
  cargo install bob-nvim

  # Create symlink for convenience
  mkdir -p ~/.local/bin
  ln -sf ~/.cargo/bin/bob ~/.local/bin/bob

  # Install Neovim 0.11.6
  bob install 0.11.6
  bob use 0.11.6

  # Create symlink to nvim
  ln -sf ~/.local/share/bob/nvim-bin/nvim ~/.local/bin/nvim
else
  echo "bob already installed"
fi

# Python neovim package
pip3 install --user pynvim

echo "Version managers configured successfully"
