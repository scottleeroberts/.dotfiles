buildrelease() {
  if [[ $# > 0 ]]; then
    wf --approved-prs | fzf -m | cut -d' ' -f1 | tr '\n' ',' | xargs wf --build-release --list $1 --pull-requests
  else
    echo "argument required (release name)"
  fi
}
