export LS_COLORS="ExfxcxdxbxegEdabagacad"
export CLICOLOR_FORCE=1


PATH="/usr/local/sbin:/usr/local/bin/bin:/usr/local/bin:$PATH:/Library/PostgreSQL/9.2/bin:${HOME}/Library/android-sdk-macosx/tools:${HOME}/Library/android-sdk-macosx/platform-tools"
MANPATH="$MANPATH:/usr/local/man/man1"
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
export PATH MANPATH LC_ALL LANG

function pyng () {
    python ~/Documents/ping.py $@
}

alias serve='python -m "SimpleHTTPServer"'

function makeiso () {
    hdiutil makehybrid -udf -udf-volume-name $1 -o $1.iso $1
}

function anagram () {
    grep2=`/usr/bin/python ~/Documents/anagram.py $1`
    grep -E "^[$1]{2,${#1}}$" /usr/share/dict/words | grep -Ev "${grep2}"
}

function scrabble () {
    anagram $1 | awk '{ print length(), $0 | "sort -nr" }' | head
}

alias xld='/Applications/XLD.app/Contents/MacOS/XLD --cmdline $@'

alias ctags='/usr/local/bin/ctags'

fpath=($HOME/.zsh/func $fpath)
typeset -U fpath
