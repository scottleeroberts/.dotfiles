install_ruby() {
  if [ -d ~/.rubies/ruby-$1 ]; then
    echo "skipping install ruby $1: already installed"
  else
    ruby-install ruby-$1
    source /usr/share/chruby/chruby.sh
    chruby $1
    gem install bundler
    gem install git-up
    gem install neovim
    gem install rubocop
    gem install ruby-lsp
    gem install ruby-lsp-rails
  fi
  echo ""
}

# Install latest stable Ruby 3.x
install_ruby "3"
