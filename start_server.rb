#!/usr/bin/env ruby

# Set up Rails environment
ENV['RAILS_ENV'] ||= 'development'

require_relative 'config/environment'

require 'puma'

app = Rails.application

Puma::Server.new(app).tap do |server|
  server.add_tcp_listener '127.0.0.1', 9292
  puts "=> Rails #{Rails.version} application starting on http://127.0.0.1:9292"
  puts "=> Use Ctrl-C to stop"
  server.run
end
