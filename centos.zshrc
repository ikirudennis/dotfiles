#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#
# turn on colors in ls
export CLICOLOR=1

# COMPLETION SETTINGS
# add custom completion scripts
fpath=(~/.zsh/completion $fpath)

autoload -U compinit
compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

autoload -U colors && colors
autoload -U promptinit && promptinit
autoload -U run-help
autoload -U zmv

bindkey -v

alias vi=/usr/bin/vim
export EDITOR=/usr/bin/vim

alias memtotal="ps -u $LOGNAME h -o rss,command | grep -e mpm -v | awk '{sum+=\$1} END {print sum/1024, \"MB\"}'"

function pyng () {
    python ~/ping27.py $@
}

#PATH=$PATH:$HOME/bin
#export PATH

PYTHONPATH=$HOME/lib/python2.5:$PYTHONPATH
export PYTHONPATH

HISTSIZE=200
HISTFILE=~/.zsh_history
SAVEHIST=200 

# If I am using vi keys, I want to know what mode I'm currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
function zle-line-init zle-keymap-select {
    zle reset-prompt
    VIMODE="${${KEYMAP/vicmd/$fg_bold[black]}/(main|viins)/$reset_color}"
}
zle -N zle-line-init
zle -N zle-keymap-select

setprompt () {
    # Need this, so the prompt will work
    setopt prompt_subst

    # let's load colors into our environment, then set them
    # autoload colors

    # if [[ "$terminfo[colors]" -ge 8 ]]; then
    #     colors
    # fi
 
    # The variables are wrapped in %{%}. This should be the case for every
    # variable that does not contain space.
    for COLOR in RED GREEN YELLOW BLUE WHITE BLACK; do
        eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
        eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
    done
 
    # Finally, let's set the prompt
    PROMPT='%{${VIMODE}%}%m%{$reset_color%}:%. %n %# '
 
    # Of course we need a matching continuation prompt
    PROMPT2='%_>'
}

setprompt
