#!/usr/bin/env ruby

ENV['RAILS_ENV'] ||= 'development'

require_relative 'config/environment'
require 'webrick'

app = Rails.application

puts "=> Rails #{Rails.version} application starting on http://127.0.0.1:9292"
puts "=> Use Ctrl-C to stop"

server = WEBrick::HTTPServer.new(
  Port: 9292,
  Host: '127.0.0.1',
  DocumentRoot: '.'
)

server.mount '/', Rack::Handler::WEBrick, app

trap('INT') { server.shutdown }
server.start
