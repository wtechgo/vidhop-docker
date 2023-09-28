#!/bin/bash

# VidHop functions - start

vidhop_docker_dir="/home/freetalk/Code-Docker/vidhop-docker"

vidhop() { # python -m cli.vidhop "$@"
  [ -z "$1" ] && echo -e "Usage: vidhop start | stop  | build" &&
    echo -e " info: Set \$vidhop_docker_dir in .bashrc to your vidhop-docker directory." && return
  [ "$1" = "start" ] && vidhop_start && return
  [ "$1" = "stop" ] && vidhop_stop && return
  [ "$1" = "build" ] && vidhop_build && return
  echo "'$1' is not a valid argument, use 'vidhop [ start | stop | build ]'"
}

vidhop-stop() {
  docker stop $(docker ps -a -q) 2>/dev/null
  docker rm $(docker ps -a -q) 2>/dev/null
}

vidhop-start() {
  vidhop-stop 1>/dev/null
  docker run --name vidhop-docker \
    -v "$vidhop_docker_dir/media:/vidhop" \
    -v "$vidhop_docker_dir/vidhop/config/.bash_history":"/root/.bash_history" \
    -it vidhop-docker /bin/bash
}

vidhop-build() {
  pwd=$(pwd)
  cd "$vidhop_docker_dir"
  [ ! -f Dockerfile ] && echo "this directory doesn't contain a Dockerfile" && return
  docker build -t vidhop-docker .
  cd "$pwd"
}

vidhop-build-nocache() {
  pwd=$(pwd)
  cd "$vidhop_docker_dir"
  [ ! -f Dockerfile ] && echo "this directory doesn't contain a Dockerfile" && return
  docker build --no-cache -t vidhop-docker .
  cd "$pwd"
}
