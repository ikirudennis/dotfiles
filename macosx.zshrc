export LS_COLORS="ExfxcxdxbxegEdabagacad"
export CLICOLOR_FORCE=1


export PATH="$PATH:/usr/local/sbin:/usr/local/bin/bin:/Library/PostgreSQL/9.1/bin:${HOME}/Library/android-sdk-mac_x86/tools:${HOME}/Library/android-sdk-mac_x86/platform-tools"
export MANPATH="$MANPATH:/usr/local/man/man1"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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

