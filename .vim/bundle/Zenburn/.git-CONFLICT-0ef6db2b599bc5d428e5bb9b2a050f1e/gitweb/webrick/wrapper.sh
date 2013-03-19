#!/bin/sh
# we use this shell script wrapper around the real gitweb.cgi since
# there appears to be no other way to pass arbitrary environment variables
# into the CGI process
GIT_EXEC_PATH=/usr/local/git/libexec/git-core GIT_DIR=/Users/dburke/.vc/dotfiles/.vim/bundle/Zenburn/.git GITWEB_CONFIG=/Users/dburke/.vc/dotfiles/.vim/bundle/Zenburn/.git/gitweb/gitweb_config.perl
export GIT_EXEC_PATH GIT_DIR GITWEB_CONFIG
exec /usr/local/git/share/gitweb/gitweb.cgi
