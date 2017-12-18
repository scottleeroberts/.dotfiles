docker_or_local() {
  if [[ -f docker-compose.yml ]]; then
    eval {"docker-compose run --rm --no-deps -e SKIP_SIMPLECOV=true web $@"}
  else
    eval {"SKIP_SIMPLECOV=true $@"}
  fi
}

be() { docker_or_local "bundle exec $@" }
ber() { docker_or_local "bundle exec rails $@" }
bes() { docker_or_local "bundle exec rspec $@" }
bu() { docker_or_local "bundle update $@" }
bi() { docker_or_local "bundle install $@" }

ddb() { docker_or_local "bundle exec rake db:drop db:setup" }
pdb() { docker_or_local "bundle exec rake parallel:drop[8] parallel:setup[8]" }
mdb() { docker_or_local "bundle exec rake db:migrate" }
mpdb() { docker_or_local "bundle exec rake parallel:migrate[8]" }

prspec() { docker_or_local "bundle exec rake parallel:spec[8]" }

