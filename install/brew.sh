#!/bin/sh

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo -e "\n\nInstalling homebrew packages..."
echo "=============================="

brew tap neovim/neovim
brew tap universal-ctags/universal-ctags

brew install cmake
brew install git
brew install git-flow
brew install imagemagick
brew install neovim
brew install zsh
brew install vim
brew install redis
brew install reattach-to-user-namespace
brew install ruby
brew install stow
brew install tree
brew install zsh
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install openssl
brew install python
brew install sqlite
brew install tmux

brew cask install iTerm2
brew cask install 1Password
brew cask install Skype
brew cask install Chrome
brew cask install Evernote
brew cask install Firefox
exit 0
