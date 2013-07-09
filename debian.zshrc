export TERM=xterm-256color

# debian's /etc/zsh/zshrc is set so that going up in the command history leaves
# the cursor at the beginning of the command.  This puts the cursor back at the
# end of the command.
# see: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=383737 for explanation
[[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" up-line-or-history
[[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" up-line-or-history
[[ "$terminfo[kcuu1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
