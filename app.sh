#!/bin/bash

build() {
  docker build -t avaliacao .
}

run() {
  docker run -it --rm -v "$PWD":/app -p 3000:3000 avaliacao
}

terminal() {
  docker run -it --rm -v "$PWD":/app avaliacao bash
}

prepare() {
  docker run -it --rm -v "$PWD":/app avaliacao bundle exec rails db:create db:migrate
}

tests() {
  docker run -it --rm -v "$PWD":/app -e RAILS_ENV='test' avaliacao bundle exec rspec spec
}

guard() {
  docker run -it --rm -v "$PWD":/app -e RAILS_ENV='test' avaliacao guard
}

display_help() {
  cat << EOF 
  USAGE: ./app.sh <option>

  Options can be:
  build - build docker image of application
  run - run rails server if there is a previously builded image
  terminal - start bash on docker image
  prepate - setup database and run migrations
  tests - run rspec tests
  guard - run rails-guard

  run without or with invalid option will print this message.
EOF
}

exec_options() {
  option=$1
  if [ -n "$(type -t $option)" ] && [ "$(type -t $option)" = function ]; then 
    $option
  else 
    display_help
  fi
}

if [ -z "$1" ]; then
  display_help
else
  exec_options $1
fi

