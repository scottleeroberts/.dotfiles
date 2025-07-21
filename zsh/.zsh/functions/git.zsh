# vi: set ft=sh :

base_branch() {
  if git rev-parse -q --verify develop > /dev/null; then
    echo "develop"
  elif git rev-parse -q --verify main > /dev/null; then
    echo "main"
  else
    echo "master"
  fi
}

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
  git add $(git status -s -u | sort | awk '{ print $2 }' | fzf -m --preview 'git diff --color=always {}')
}

grm() {
  rm -dir $(git status -s -u | sort | awk '{ print $2 }' | fzf -m --preview 'git diff --color=always {}')
}


ap() {
  local files
  files=$(git status --porcelain | sort | cut -c4- | fzf -m --preview 'git diff --color=always "$REPLY"') || return
  if [[ -n "$files" ]]; then
    echo "$files" | while IFS= read -r file; do
      git add -p "$file"
    done
  fi
}

co() {
  if [[ $# > 0 ]]; then
    git checkout HEAD -- $@
  else
    git checkout $(git status -s -u | sort | awk '{ print $2 }' | fzf -m --preview 'git diff --color=always {}')
  fi
}

br() {
  if [[ $# -eq 0 ]]; then
    local base_branch target
    base_branch=$(base_branch)
    target=$(git branch --format='%(refname:short)' | fzf --preview "git short-log $base_branch..{} | head") || return
    if [[ -n "$target" ]]; then
      git switch "$target"
    fi
  fi
}

gbd() {
  if [[ $# -eq 0 ]]; then
    local base_branch targets
    base_branch=$(base_branch)

    # Fetch the latest branches from the remote
    git fetch origin

    # Get a list of local branches excluding the base branch
    targets=$(git branch --format='%(refname:short)' | grep -v "^$base_branch$" | fzf -m --preview "git short-log $base_branch..{} | head") || return

    if [[ -n "$targets" ]]; then
      echo "Deleting branches:"
      echo "$targets"

      # Prompt the user for confirmation without using read -p
      echo -n "Are you sure you want to delete the selected branches? [y/N] "
      read confirm

      if [[ "$confirm" =~ ^[Yy]$ ]]; then
        echo "$targets" | xargs -n 1 git branch -D
        echo "Selected branches have been deleted."
      else
        echo "Branch deletion canceled."
      fi
    else
      echo "No branches selected for deletion."
    fi
  else
    echo "gbd: This function does not accept arguments."
  fi
}

cfu() {
  local base_branch target
  base_branch=$(base_branch)
  target=$(git log --pretty=format:"%H %s" "$base_branch".. | fzf --preview 'git show --color=always --pretty=fuller --stat {1}' | awk '{ print $1 }') || return
  if [[ -n "$target" ]]; then
    git commit --fixup "$target"
  fi
}

gdm () {
  base_branch=$(base_branch)

  if [[ $base_branch == "main" ]]
  then
    git branch --merged origin/main | grep -v main | xargs git branch -d
  elif [[ $base_branch == "develop" ]]
  then
    git branch --merged origin/develop | grep -v develop | xargs git branch -d
  else
    git branch --merged origin/master | grep -v master | xargs git branch -d
  fi
}

cherry() {
  base_branch=$(base_branch)
  branches=$(git branch)
  target_branch=$(echo $branches | awk '{$1=$1};1' | $(fzf_prog) --preview 'git short-log $base_branch..{} | head')

  git cherry-pick $(git log --pretty=oneline $(echo $target_branch) | $(fzf_prog) -m --preview "echo {} | cut -f 1 -d' ' | xargs -I SHA git show --color=always --pretty=fuller --stat SHA"| awk '{ print $1 }' )
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
