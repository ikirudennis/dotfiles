# universal zshrc settings
export dotfiles_version=1.1

# use vim keybindings by default
bindkey -v

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

export EDITOR=/usr/bin/vim

# turn on colors in ls
export CLICOLOR=1

# colorize less output
export LESS="R"
export PAGER=less

# load zsh modules
autoload -U colors && colors
autoload -U promptinit && promptinit
autoload -U run-help
autoload -U zmv
autoload -Uz zsh/terminfo
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable hg git
precmd() {
	vcs_info
}

# load this module, but don't complain if it's already loaded
zmodload -i zsh/datetime

# zsh boolean options
setopt complete_in_word
setopt correct
setopt extended_glob
setopt hash_list_all
setopt prompt_subst
setopt auto_cd

# zsh history configurations
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=1000

setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt append_history
setopt extended_history
setopt share_history

eval "`npm completion`"

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
    VIMODE="${${KEYMAP/vicmd/$fg_no_bold[red]}/(main|viins)/$reset_color}"
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
    PROMPT='%{${VIMODE}%}%m%{$reset_color%}${vcs_info_msg_0_}:%. %n %# '

    # Of course we need a matching continuation prompt
    PROMPT2='%_>'
}

setprompt

function sshscreen () {
    ssh -t $1 screen
}

function zsh_stats () {
    history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

alias vi=/usr/bin/vim

alias zcp=zmv -C
alias zls=zmv -L

if [[ -s $HOME/.zshrc_local ]] ; then
    source $HOME/.zshrc_local ;
fi

if [[ -s $HOME/.zshrc_private ]] ; then
    source $HOME/.zshrc_private ;
fi

# this needs to be last to load completions in ~/.zsh/func/
autoload -U compinit && compinit

eval "`pip completion --zsh`"

# added by Pew
source $(pew shell_config)
