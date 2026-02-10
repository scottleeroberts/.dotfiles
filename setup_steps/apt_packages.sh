#!/bin/bash
# APT package installation for Ubuntu

echo "Installing APT packages..."

# Core system tools
sudo apt install -y \
  build-essential \
  git \
  curl \
  wget \
  stow \
  zsh \
  zsh-syntax-highlighting \
  tmux \
  openssh-client \
  unzip \
  ripgrep

# i3 window manager and utilities
sudo apt install -y \
  i3 \
  i3blocks \
  i3lock \
  i3status \
  rofi \
  dunst \
  picom \
  feh \
  scrot \
  arandr

# Audio/Video
sudo apt install -y \
  pavucontrol \
  alsa-utils

# Desktop applications
sudo apt install -y \
  firefox \
  evince \
  nemo

# Development tools
sudo apt install -y \
  aspell \
  aspell-en

# Fonts
sudo apt install -y \
  fonts-dejavu-core \
  fonts-dejavu-mono \
  fonts-liberation \
  fonts-noto-core \
  fonts-noto-mono \
  fonts-noto-color-emoji \
  fonts-ubuntu

# Font cache rebuild
fc-cache -f -v

echo "APT packages installed successfully"

# ARCHIVED: Not installed on current machine
# Uncomment if needed for your use case

# Cloud/Platform CLIs
# sudo apt install -y awscli  # Use aws-cli from pip instead
# sudo snap install heroku --classic

# Database Tools
# pip install pgcli  # PostgreSQL CLI with autocompletion

# Media/Communication
# sudo snap install signal-desktop --classic
# sudo apt install -y weechat  # IRC client

# Development utilities
# sudo apt install -y mosh  # Mobile shell
# sudo apt install -y ncdu  # Disk usage analyzer (use btop instead)
# pip install youtube-dl  # Video downloader (or yt-dlp)

# Fonts (replaced by system fonts)
# Manual font installation if needed:
# - Fantasque Sans Mono
# - Monaco
# - Victor Mono
# - Nerd Fonts (install from https://www.nerdfonts.com/)

# PulseAudio extensions
# sudo apt install -y pulseaudio-equalizer
# sudo apt install -y pulseaudio-bluetooth

# Security/Safety
# sudo apt install -y safe-rm  # Safer rm command

# Niche hardware tools
# sudo apt install -y teensy-loader-cli  # For Teensy hardware

# Alternative package managers
# gcalcli  # Google Calendar CLI - install via pip if needed

# Color temperature (redshift/gammastep)
# sudo apt install -y gammastep  # Blue light filter (if not using Flux/similar)
