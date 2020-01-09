export DOTFILES=$HOME/.dotfiles

export EDITOR=nvim
export BROWSER="firefox"

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:~/bin:~/scripts:/opt/local/sbin:$PATH"
export PATH="$DOTFILES/bin:$PATH"

export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_GC_HEAP_SLOTS_INCREMENT=1000000
export RUBY_GC_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_GC_HEAP_FREE_MIN=500000

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_COMPLETION_TRIGGER=',,'
export RSPEC_CORES=8
export FILTHY_SHOW_EXIT_CODE=1

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
