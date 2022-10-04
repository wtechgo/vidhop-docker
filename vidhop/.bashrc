. /opt/vidhop/bin/loader    # Load VidHop.

PS1='\u\[\033[0;95m\]@\[\033[0m\]\w\[\033[0;95m\]8> \[\033[0m\]'

alias ll='ls -lrth --color=auto'
alias la='ls -lrthA --color=auto'
alias cp='cp -r'
alias nanobash='nano $HOME/.bashrc; source $HOME/.bashrc'
alias reloadshell='source $HOME/.bashrc'

HISTSIZE=500
HISTFILESIZE=500
HISTFILE=$HOME/.bash_history
set -o history
