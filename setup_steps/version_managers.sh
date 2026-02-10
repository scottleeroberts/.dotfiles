#!/bin/bash
# Version managers for Node, Neovim, etc.

echo "Setting up version managers..."

# Node.js (via NodeSource)
echo "Installing Node.js v24.x via NodeSource..."
if ! command -v node &> /dev/null; then
  if curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -; then
    sudo apt install -y nodejs
    echo "Node.js installed successfully"
  else
    echo "Warning: Node.js installation failed"
  fi
else
  echo "Node.js already installed: $(node --version)"
fi

# Bob (Neovim version manager)
echo "Installing bob (Neovim version manager)..."
if ! command -v bob &> /dev/null; then
  # Install Rust (needed for bob)
  if ! command -v cargo &> /dev/null; then
    echo "Installing Rust..."
    if curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; then
      source "$HOME/.cargo/env" || export PATH="$HOME/.cargo/bin:$PATH"
      echo "Rust installed successfully"
    else
      echo "Warning: Rust installation failed, skipping bob installation"
      return 0
    fi
  fi

  # Install bob
  echo "Installing bob-nvim..."
  if cargo install bob-nvim; then
    # Create symlink for convenience
    mkdir -p ~/.local/bin
    ln -sf ~/.cargo/bin/bob ~/.local/bin/bob

    # Install Neovim 0.11.6
    echo "Installing Neovim 0.11.6 via bob..."
    if bob install 0.11.6 && bob use 0.11.6; then
      # Create symlink to nvim
      ln -sf ~/.local/share/bob/nvim-bin/nvim ~/.local/bin/nvim
      echo "Neovim installed successfully"
    else
      echo "Warning: Neovim installation via bob failed"
    fi
  else
    echo "Warning: bob installation failed"
  fi
else
  echo "bob already installed: $(bob --version 2>/dev/null || echo 'version unknown')"
fi

# Python neovim package
echo "Installing Python neovim support..."
if pip3 install --user pynvim 2>/dev/null; then
  echo "Python neovim package installed"
else
  echo "Warning: Failed to install pynvim (may need python3-pip)"
fi

echo "Version managers setup complete"
