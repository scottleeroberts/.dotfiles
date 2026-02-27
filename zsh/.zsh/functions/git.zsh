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

a() {
  git add $(git status -s -u | sort | awk '{ print $2 }' | fzf -m --preview 'git diff --color=always {}')
}

r() {
  rm -dir $(git status -s -u | sort | awk '{ print $2 }' | fzf -m --preview 'git diff --color=always {}')
}

rmf() {
  if [[ $# > 0 ]]; then
    rm "$@"
  else
    local files
    files=$(git status -s -u | sort | awk '{ print $2 }' | fzf -m --preview 'git diff --color=always {}') || return
    if [[ -n "$files" ]]; then
      echo "$files" | while IFS= read -r file; do
        rm "$file"
      done
    fi
  fi
}

ap() {
  local files
  files=$(git status --porcelain | sort | cut -c4- | fzf -m --preview 'git diff --color=always {}') || return
  if [[ -n "$files" ]]; then
    echo "$files" | while IFS= read -r file; do
      git add -p "$file" < /dev/tty
    done
  fi
}

co() {
  # Handle -b flag for branch operations
  if [[ "$1" == "-b" ]]; then
    if [[ $# -eq 1 ]]; then
      # co -b: fzf branch selection
      local base_branch target
      base_branch=$(base_branch)
      target=$(git branch --format='%(refname:short)' | fzf --preview "git log --oneline $base_branch..{} | head -20") || return
      if [[ -n "$target" ]]; then
        git checkout "$target" && echo "Switched to branch '$target'"
      fi
    else
      # co -b new-branch: create new branch
      shift
      git checkout -b "$1" && echo "Created and switched to new branch '$1'"
    fi
  elif [[ $# -gt 0 ]]; then
    git checkout "$@"
  else
    # No args: fzf file selection
    local files
    files=$(git status -s -u | sort | awk '{ print $2 }' | fzf -m --preview 'git diff --color=always {}') || return
    if [[ -n "$files" ]]; then
      echo "$files" | while IFS= read -r file; do
        git checkout HEAD -- "$file"
      done
      echo "Reverted selected files"
    fi
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
    targets=$(git branch --format='%(refname:short)' | grep -v "^$base_branch$" | fzf -m --preview "git log --oneline $base_branch..{} | head") || return

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

  [[ -z $(git status --porcelain) ]] && echo "No changes to commit" && return 1

  base_branch=$(base_branch)

  target=$(git log --pretty=format:"%H %ad %an | %s" --date=relative "$base_branch".. | \
    fzf --preview 'git show --color=always --pretty=fuller --stat {1}' | \
    awk '{ print $1 }') || return

  git add -A
  git commit --fixup "$target"
  git rebase -i --autosquash "$base_branch"
}

gdm () {
  local bb=$(base_branch)
  git branch --merged "origin/$bb" | grep -v "$bb" | xargs git branch -d
}

cherry() {
  base_branch=$(base_branch)
  branches=$(git branch)
  target_branch=$(echo $branches | awk '{$1=$1};1' | fzf --preview 'git short-log $base_branch..{} | head')

  git cherry-pick $(git log --pretty=oneline $(echo $target_branch) | fzf -m --preview "echo {} | cut -f 1 -d' ' | xargs -I SHA git show --color=always --pretty=fuller --stat SHA"| awk '{ print $1 }' )
}

gcm() {
  if git rev-parse -q --verify main > /dev/null; then
    git checkout main
  else
    git checkout master
  fi
}

alias gco="git checkout"
alias gss="git status"
alias gcd="git checkout develop"
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
