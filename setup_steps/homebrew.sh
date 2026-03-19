#!/bin/bash
# Homebrew (Linuxbrew) installation and packages

echo "Installing Homebrew (Linuxbrew)..."

# Check if Homebrew is already installed
if ! command -v brew &> /dev/null; then
  # Install Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for this session
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  # Add to shell profile (if not already there)
  if ! grep -q 'eval.*brew shellenv' ~/.zshrc 2>/dev/null; then
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
  fi
else
  echo "Homebrew already installed"
fi

echo "Installing Homebrew packages..."

# Development tools
brew install \
  buf \
  gh \
  tig \
  fzf \
  ripgrep \
  fd \
  btop \
  htop \
  speedtest-cli

# Ruby tools
brew install \
  chruby \
  ruby-install

# Docker tools
brew install \
  docker-compose \
  lazydocker

# Language runtimes
brew install \
  go \
  python@3.13

# System utilities
brew install \
  xclip

echo "Homebrew packages installed successfully"
