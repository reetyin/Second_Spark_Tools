#!/usr/bin/env ruby

ENV['RAILS_ENV'] ||= 'development'

require_relative 'config/environment'
require 'socket'

app = Rails.application

server = TCPServer.new('127.0.0.1', 9292)

puts "=> Rails #{Rails.version} application starting on http://127.0.0.1:9292"
puts "=> Use Ctrl-C to stop"

loop do
  begin
    client = server.accept
    request_line = client.gets
    
    if request_line
      method, path, version = request_line.split
      
      # Create a basic Rack environment
      env = {
        'REQUEST_METHOD' => method,
        'PATH_INFO' => path,
        'SERVER_NAME' => '127.0.0.1',
        'SERVER_PORT' => '9292',
        'rack.input' => StringIO.new,
        'rack.errors' => $stderr
      }
      
      status, headers, body = app.call(env)
      
      response = "HTTP/1.1 #{status}\r\n"
      headers.each { |k, v| response += "#{k}: #{v}\r\n" }
      response += "\r\n"
      
      body.each { |chunk| response += chunk }
      
      client.write(response)
    end
  rescue => e
    puts "Error: #{e.message}"
  ensure
    client&.close
  end
end
