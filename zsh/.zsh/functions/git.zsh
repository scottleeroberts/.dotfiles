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

set_base_branch() {
  git rev-parse --verify develop
  if [[ $? == 0 ]]; then
    BASE_BRANCH="develop"
  else
    BASE_BRANCH="master"
  fi
}

ir() {
  set_base_branch
  git rebase -i $BASE_BRANCH
}

changes() {
  if [[ $# > 0 ]]; then
    tig "$@".."$(git rev-parse --abbrev-ref HEAD)"
  else
    set_base_branch
    tig $BASE_BRANCH.."$(git rev-parse --abbrev-ref HEAD)"
  fi
}

alias gco="git checkout"
alias gss="git status"
alias gcd="git checkout develop"
alias gcm="git checkout master "
alias stash="git stash"
alias pop="git stash pop"
alias back='git reset HEAD~1'
alias d="git diff"
alias ds="git diff --staged"
alias push="git push"
alias pull="git pull"
alias fpush="git push --force"
alias unstage="git unstage"
alias cherry="git cherry-pick"
alias gun="git reset HEAD"
alias releases="git log | grep -v 'tag: ' | grep -i 'feature\|hotfix'"
alias churn="git log --all --name-only --format='format:' | grep -v '^$' | sort | uniq -c | sort -n | tail"
alias gs="git st"
alias gl="git lg"
alias gcv="git commit -v"
