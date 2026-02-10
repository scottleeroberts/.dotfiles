create_ticket() {
  ppwf --create-issue
}

finished() {
  ppwf --create-pr
}

draft() {
  ppwf --create-draft-pr
}

my_prs() {
  ppwf --my-prs
}

next_story() {
  issue=$(ppwf --list-issues | fzf | awk '{print $1;}')
  ppwf --work-issue --issue $issue
}
