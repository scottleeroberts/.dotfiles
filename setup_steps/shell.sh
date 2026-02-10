set_default_shell() {
  # Check if running in Docker
  if [ -f /.dockerenv ]; then
    echo "Docker environment detected - skipping default shell change"
    echo "In Docker, the shell is typically set via CMD/ENTRYPOINT"
    echo ""
    return 0
  fi

  if [ "$SHELL" == "$1" ]; then
    echo "skipping change shell: shell is already $1"
  else
    if [ -f "$1" ]; then
      echo "setting shell to $1"
      chsh -s "$1"
    else
      echo "Warning: $1 not found, skipping shell change"
    fi
  fi
  echo ""
}

set_default_shell "/usr/bin/zsh"
