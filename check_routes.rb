#!/usr/bin/env ruby

require_relative 'config/environment'

puts "Available Routes:"
puts "=================="

Rails.application.routes.routes.each do |route|
  puts "#{route.verb.ljust(10)} #{route.path.spec.to_s.ljust(40)} #{route.defaults[:controller]}##{route.defaults[:action]}"
end
