# Customize to your needs...
export EDITOR=nvim
export PATH="/usr/local/rvm/bin/:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:~/bin:~/scripts:/opt/local/sbin:$PATH"

export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_GC_HEAP_SLOTS_INCREMENT=1000000
export RUBY_GC_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_GC_HEAP_FREE_MIN=500000

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export CTAGS_COMMAND="/usr/local/bin/ctags --extra=+f -R --exclude=.git --exclude=log --exclude=tmp *"

#use colors
source ~/.zsh/base16-ocean.dark.sh
# makes color constants available
autoload -U colors
colors

#load custom functions
for function in ~/.zsh/functions/*; do
  source $function
done

export FZF_COMPLETION_TRIGGER=",,"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey -v
bindkey jj vi-cmd-mode
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^v" edit-command-line

autoload -U promptinit && promptinit
autoload -Uz compinit && compinit
prompt filthy

opentmux

[[ -f ~/.aliases ]] && source ~/.aliases ]]
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local ]]
