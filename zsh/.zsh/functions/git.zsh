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


a() {
  if [ "$TMUX" = "" ]; then
    git add $(git status -s -u | sort | awk '{ print $2 }' | fzf -m --preview 'git diff --color=always {}')
  else
    git add $(git status -s -u | sort | awk '{ print $2 }' | fzf-tmux -m --preview 'git diff --color=always {}')
  fi
}


ap() {
  if [ "$TMUX" = "" ]; then
    git add -p $(git status -s -u | sort | awk '{ print $2 }' | fzf -m --preview 'git diff --color=always {}')
  else
    git add -p $(git status -s -u | sort | awk '{ print $2 }' | fzf-tmux -m --preview 'git diff --color=always {}')
  fi
}

co() {
  if [[ $# > 0 ]]; then
    git co $@
  else
    if [ "$TMUX" = "" ]; then
      git co $(git status -s -u | sort | awk '{ print $2 }' | fzf -m --preview 'git diff --color=always {}')
    else
      git co $(git status -s -u | sort | awk '{ print $2 }' | fzf-tmux -m --preview 'git diff --color=always {}')
    fi
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

br() {
  if [[ $# == 0 ]]; then
    set_base_branch

    branches=$(git branch)
    if [ "$TMUX" = "" ]; then
      target=$(echo $branches | awk '{$1=$1};1' | fzf --preview 'git short-log $BASE_BRANCH..{} | head')
    else
      target=$(echo $branches | awk '{$1=$1};1' | fzf-tmux --preview 'git short-log $BASE_BRANCH..{} | head')
    fi

    if [[ $target != '' ]]; then
      git checkout $(echo $target)
    fi
  fi
}

cfu() {
  set_base_branch
  if [ "$TMUX" = "" ]; then
    target=$(git log --pretty=oneline $BASE_BRANCH.. | fzf --preview "echo {} | cut -f 1 -d' ' | xargs -I SHA git show --color=always --pretty=fuller --stat SHA" | awk '{ print $1 }')
  else
    target=$(git log --pretty=oneline $BASE_BRANCH.. | fzf-tmux --preview "echo {} | cut -f 1 -d' ' | xargs -I SHA git show --color=always --pretty=fuller --stat SHA" | awk '{ print $1 }')
  fi

  if [[ $target != '' ]]; then
    git commit --fixup $(echo $target)
  fi
}

alias gco="git checkout"
alias gss="git status"
alias gcd="git checkout develop"
alias gcm="git checkout master "
alias gstash="git stash"
alias gpop="git stash pop"
alias gback='git reset HEAD~1'
alias glast='git log -1 --pretty=%B'
alias gd="git diff"
alias gds="git diff --staged"
alias gp="git push"
alias gpull="git pull"
alias gfpush="git push --force"
alias gunstage="git unstage"
alias gcherry="git cherry-pick"
alias gun="git reset HEAD"
alias gclean="git clean -fd"
alias greleases="git log | grep -v 'tag: ' | grep -i 'feature\|hotfix'"
alias gchurn="git log --all --name-only --format='format:' | grep -v '^$' | sort | uniq -c | sort -n | tail"
alias gs="git st"
alias gl="git lg"
alias gcv="git commit -v"
