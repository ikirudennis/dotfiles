# On centos5, zsh doesn't properly handle the whole vimode advanced
# configuration I had set up.  Dumb down the prompt and we should be good.
PROMPT='%m:%. %n %# '
#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#
# turn on colors in ls

# COMPLETION SETTINGS
# add custom completion scripts
fpath=(~/.zsh/completion $fpath)

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0




alias memtotal="ps -u $LOGNAME h -o rss,command | grep -e mpm -v | awk '{sum+=\$1} END {print sum/1024, \"MB\"}'"

function pyng () {
    python ~/ping27.py $@
}

#PATH=$PATH:$HOME/bin
#export PATH

PYTHONPATH=$HOME/lib/python2.7:$PYTHONPATH
export PYTHONPATH

TZ=America/New_York
export TZ

alias tmux=$HOME/bin/tmux

TMUX_V16=1
export TMUX_V16
