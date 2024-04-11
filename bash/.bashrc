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
export RSPEC_CORES=6
export FILTHY_SHOW_EXIT_CODE=1
export NODE_OPTIONS="--max-old-space-size=16384"



# Load custom functions
for function in ~/.bash/functions/*; do
  source $function
done

# Set vi mode and key bindings
set -o vi
bind -m vi-command "jj:vi-movement-mode"
bind -m vi-insert "^A:beginning-of-line"
bind -m vi-insert "^E:end-of-line"
bind -m vi-insert "^R:reverse-search-history"
# Note: Bash doesn't support in-place command-line editing like Zsh's `edit-command-line`

# Load aliases and local settings
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.bashrc.local ]] &&  source ~/.bashrc.local

# Open tmux (if this is a custom function, make sure it's defined in your loaded functions)
opentmux
