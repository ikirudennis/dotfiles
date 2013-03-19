#!/usr/bin/env ruby
require 'webrick'
require 'logger'
options = {
  :Port => 1234,
  :DocumentRoot => "/usr/local/git/share/gitweb",
  :Logger => Logger.new('/Users/dburke/.vc/dotfiles/.vim/bundle/Zenburn/.git/gitweb/error.log'),
  :AccessLog => [
    [ Logger.new('/Users/dburke/.vc/dotfiles/.vim/bundle/Zenburn/.git/gitweb/access.log'),
      WEBrick::AccessLog::COMBINED_LOG_FORMAT ]
  ],
  :DirectoryIndex => ["gitweb.cgi"],
  :CGIInterpreter => "/Users/dburke/.vc/dotfiles/.vim/bundle/Zenburn/.git/gitweb/webrick/wrapper.sh",
  :StartCallback => lambda do
    File.open("/Users/dburke/.vc/dotfiles/.vim/bundle/Zenburn/.git/pid", "w") { |f| f.puts Process.pid }
  end,
  :ServerType => WEBrick::Daemon,
}
options[:BindAddress] = '127.0.0.1' if "" == "true"
server = WEBrick::HTTPServer.new(options)
['INT', 'TERM'].each do |signal|
  trap(signal) {server.shutdown}
end
server.start
