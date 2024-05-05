# Unset options
shopt -u nullglob

# History settings
HISTFILE=~/.bash_history
HISTSIZE=10000
HISTFILESIZE=10000

shopt -s histappend

export DOTFILES="$HOME/.dotfiles"
export EDITOR="nvim"
export BROWSER="firefox"
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/scripts:/opt/local/sbin:$PATH"
export PATH="$DOTFILES/bin:$PATH"
export PATH="/usr/share:$PATH"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_COMPLETION_TRIGGER=',,'
export FILTHY_SHOW_EXIT_CODE=1

# Load custom functions
for function in ~/.bash/functions/*; do
  source $function
done

# Load aliases and local settings
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.bashrc.local ]] &&  source ~/.bashrc.local

opentmux

export EJSON_KEYDIR=~/.keys
export DLDFLAGS="-Wl,-undefined,dynamic_lookup"
command -v rbenv &> /dev/null && eval "$(rbenv init -)"
export NVM_DIR="$HOME/.nvm"
[ -s "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" ] && . "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh"
[ -s "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm" ] && . "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm"
