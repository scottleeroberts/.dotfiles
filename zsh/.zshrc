# Customize to your needs...
export EDITOR=nvim
export PATH="/usr/local/rvm/bin/:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:~/bin:~/scripts:/opt/local/sbin:$PATH"

export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_GC_HEAP_SLOTS_INCREMENT=1000000
export RUBY_GC_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_GC_HEAP_FREE_MIN=500000

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt inc_append_history
setopt extended_history

#use colors
source ~/.zsh/base16-ocean.dark.sh
# makes color constants available
autoload -U colors
colors

#load custom functions
for function in ~/.zsh/functions/*; do
  source $function
done

autoload -z edit-command-line
zle -N edit-command-line
bindkey -v
bindkey jj vi-cmd-mode
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^v" edit-command-line

autoload -U promptinit && promptinit
autoload -Uz compinit && compinit
prompt filthy

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export fzf_completion_trigger=",,"

opentmux

# install zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# install zsh autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f ~/.aliases ]] && source ~/.aliases ]]
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local ]]
