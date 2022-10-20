vidhop_stop() {
  docker stop $(docker ps -a -q) 2>/dev/null
  docker rm $(docker ps -a -q) 2>/dev/null
}

vidhop_start() {
  vidhop_stop 1>/dev/null
  docker run --name vidhop-docker \
    -v "$PWD/media:/vidhop" \
    -v "$PWD/vidhop/.bash_history":"/root/.bash_history" \
    -it vidhop-docker /bin/bash
}

vidhop_build() {
  [ ! -f Dockerfile ] && echo "this directory doesn't contain a Dockerfile" && return
  docker build -t vidhop-docker .
}

vidhop_build_no_cache() {
  docker build --no-cache -t vidhop-docker .
}

vidhop() {
  [ -z "$1" ] && echo -e "usage: vidhop start | stop  | build" && return
  [ "$1" = "start" ] && vidhop_start && return
  [ "$1" = "stop" ] && vidhop_stop && return
  [ "$1" = "build" ] && vidhop_build && return
  echo "'$1' is not a valid argument, use 'vidhop [ start | stop | build ]'"
}

alias ll='ls -lrth --color=auto'
alias la='ls -lrthA --color=auto'
alias cp='cp -r'
alias nanobashrc='nano $HOME/.bashrc; source $HOME/.bashrc'
alias reloadsh='source $HOME/.bashrc'
