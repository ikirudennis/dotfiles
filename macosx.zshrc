bindkey -v

export EDITOR=/usr/bin/vim

export LS_COLORS="ExfxcxdxbxegEdabagacad"
export CLICOLOR=1
export CLICOLOR_FORCE=1


HISTSIZE=200
HISTFILE=~/.zsh_history
SAVEHIST=200
setopt INC_APPEND_HISTORY

setopt CORRECT

export PATH="$PATH:/usr/local/sbin:/usr/local/bin/bin:/Library/PostgreSQL/9.0/bin:${HOME}/Library/android-sdk-mac_x86/tools:${HOME}/Library/android-sdk-mac_x86/platform-tools"
export MANPATH="$MANPATH:/usr/local/man/man1"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

autoload -U colors && colors
autoload -U promptinit && promptinit
autoload -U compinit && compinit
autoload -U run-help
autoload -U zmv
autoload -Uz zsh/terminfo

zmodload zsh/datetime

# If I am using vi keys, I want to know what mode I am currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
function zle-line-init zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/$fg_bold[black]}/(main|viins)/$reset_color}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

setprompt () {
    # Need this, so the prompt will work
    setopt prompt_subst

    # load colors into our environment, then set them
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

    # Finally, set the prompt
    PROMPT='%{${VIMODE}%}%m%{$reset_color%}:%. %n %# '

    # Of course we need a matching continuation prompt
    PROMPT2='%_>'
}

setprompt

function pyng () {
	python ~/Documents/ping.py $@
}

alias serve='python -m "SimpleHTTPServer"'

function ptpmakeiso () {
	hdiutil makehybrid -udf -udf-volume-name $1 -o $1.iso $1
}
function sshscreen () {
	ssh -t $1 screen
}

function anagram () {
	grep2=`/usr/bin/python ~/Documents/anagram.py $1`
	grep -E "^[$1]{2,${#1}}$" /usr/share/dict/words | grep -Ev "${grep2}"
}

eval "`pip completion --zsh`"

if [[ "$terminfo[colors]" -eq 256 ]]; then
	export LESS_TERMCAP_mb=$'\E[01;31m'
	export LESS_TERMCAP_md=$'\E[01;38;5;74m'
	export LESS_TERMCAP_me=$'\E[0m'

	export LESS_TERMCAP_so=$'\E[01;48;5;33m'
	export LESS_TERMCAP_se=$'\E[0m'

	export LESS_TERMCAP_us=$'\E[04;33;146m'
	export LESS_TERMCAP_ue=$'\E[0m'
else
	export LESS_TERMCAP_mb=$'\E[01;31m'
	export LESS_TERMCAP_md=$'\E[01;34m'
	export LESS_TERMCAP_me=$'\E[0m'

	export LESS_TERMCAP_so=$'\E[44m\E[01m'
	export LESS_TERMCAP_se=$'\E[0m'

	export LESS_TERMCAP_us=$'\E[01;04;33m'
	export LESS_TERMCAP_ue=$'\E[0m'
fi
export LESS="FSR"
export PAGER=less
