alias dkr="docker"
alias c="docker-compose"
alias up="docker-compose up"
alias down="docker-compose down"
alias rw="docker-compose run web bundle exec rake resque:work QUEUE=*"

dr_nuke_containers() {
  docker rm -f $(docker ps -a -q)
}

dr_nuke_images() {
  docker rmi -f $(docker images -a -q)
}

dr_nuke_volumes(){
  docker volume rm $(docker volume ls -q)
}

dr_nuke_networks(){
  docker network rm $(docker network ls | tail -n+2 | awk '{if($2 !~ /bridge|none|host/){ print $1 }}')
}

dr_db() {
  containers=$(docker ps -a --format "{{.ID}} {{.Names}} {{.Image}}" | grep unsafe_postgres)
  target=$(echo $containers | $(fzf_prog) | awk '{ print $1 }')
  echo $containers | awk '{ print $1 }' | xargs -I NAME docker stop NAME > /dev/null
  docker start $target > /dev/null
}

dr_stop(){
  containers=$(docker ps --format "{{.ID}} {{.Names}} {{.Image}}" )
  target=$(echo $containers | $(fzf_prog) | awk '{ print $1 }')
  docker stop $target > /dev/null
}


