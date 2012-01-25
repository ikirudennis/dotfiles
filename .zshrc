# universal zshrc settings

# use vim keybindings by default
bindkey -v

export EDITOR=/usr/bin/vim

# turn on colors in ls
export CLICOLOR=1

# colorize less output
export LESS="R"
export PAGER=less

# load zsh modules
autoload -U colors && colors
autoload -U compinit && compinit
autoload -U promptinit && promptinit
autoload -U run-help
autoload -U zmv
autoload -Uz zsh/terminfo

# load this module, but don't complain if it's already loaded
zmodload -i zsh/datetime

# zsh boolean options
setopt complete_in_word
setopt correct
setopt extended_glob
setopt hash_list_all
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history
setopt prompt_subst

# zsh configurations
HISTSIZE=200
HISTFILE=~/.zsh_history
SAVEHIST=200

eval "`pip completion --zsh`"

# define colors used by less
if [[ "$terminfo[colors]" -eq 256 ]]; then
    # this is for advanced terminals that use 256 colors
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;38;5;74m'
    export LESS_TERMCAP_me=$'\E[0m'

    export LESS_TERMCAP_so=$'\E[48;5;33m'
    export LESS_TERMCAP_se=$'\E[0m'

    export LESS_TERMCAP_us=$'\E[04;33;146m'
    export LESS_TERMCAP_ue=$'\E[0m'
else
    # otherwise, approximate the pretty colors above
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;34m'
    export LESS_TERMCAP_me=$'\E[0m'

    export LESS_TERMCAP_so=$'\E[44m'
    export LESS_TERMCAP_se=$'\E[0m'

    export LESS_TERMCAP_us=$'\E[01;04;33m'
    export LESS_TERMCAP_ue=$'\E[0m'
fi


# If I am using vi keys, I want to know what mode I am currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
function zle-line-init zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/$fg_bold[red]}/(main|viins)/$reset_color}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

setprompt () {

    # The variables are wrapped in %{%}. This should be the case for every
    # variable that does not contain space.
    for COLOR in RED GREEN YELLOW BLUE WHITE BLACK; do
        eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
        eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
    done

    # Finally, set the prompt
    PROMPT='%{${VIMODE}%}%m%{$reset_color%}:%. %n %# '

    # Of course we need a matching continuation prompt
    PROMPT2='%_>'
}

setprompt

function sshscreen () {
    ssh -t $1 screen
}

alias vi=/usr/bin/vim

if [[ -s $HOME/.zshrc_local ]] ; then
    source $HOME/.zshrc_local ;
fi
