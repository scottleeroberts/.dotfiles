# vi: set ft=sh :

g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

cm() {
  if [[ $# > 0 ]]; then
    git commit -m $@
  else
    git commit -v
  fi
}


dev() {
  git checkout develop && git up
}

br() {
  if [[ $# == 0 ]]; then
    branches=$(git branch)
    if [ "$TMUX" = "" ]; then
      target=$(echo $branches | fzf)
    else
      target=$(echo $branches | fzf-tmux)
    fi

    if [[ $target != '' ]]; then
      git checkout $(echo $target)
    fi
  fi
}

a() {
  if [ "$TMUX" = "" ]; then
    git add $(git status -s | awk '{ print $2 }' | fzf -m)
  else
    git add $(git status -s | awk '{ print $2 }' | fzf-tmux -m)
  fi
}

ap() {
  if [ "$TMUX" = "" ]; then
    git add -p $(git status -s | awk '{ print $2 }' | fzf -m)
  else
    git add -p $(git status -s | awk '{ print $2 }' | fzf-tmux -m)
  fi
}

cfu() {
  if [ "$TMUX" = "" ]; then
    target=$(git log --pretty=oneline develop.. | fzf | awk '{ print $1 }')
  else
    target=$(git log --pretty=oneline develop.. | fzf-tmux | awk '{ print $1 }')
  fi

  if [[ $target != '' ]]; then
    git commit --fixup $(echo $target)
  fi
}

alias gco="git checkout"
alias co="git checkout"
alias cl="git clone"
alias gss="git status"
alias gcd="git checkout develop"
alias gcm="git checkout master "

alias d="git diff"
alias ds="git diff --staged"

alias gp="git push"
alias gb="git branch"
alias gcp="git cherry-pick"
alias gun="git reset HEAD"

alias releases="git log | grep -v 'tag: ' | grep -i 'feature\|hotfix'"

alias churn="git log --all --name-only --format='format:' | grep -v '^$' | sort | uniq -c | sort -n | tail"