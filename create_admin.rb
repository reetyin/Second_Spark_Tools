#!/usr/bin/env ruby

require_relative 'config/environment'

puts "=== 创建管理员用户 ==="

# 检查是否已有管理员
if User.admin.exists?
  admin = User.admin.first
  puts "管理员已存在:"
  puts "邮箱: #{admin.email}"
  puts "你可以用密码 'admin123' 登录"
else
  # 创建管理员用户
  admin = User.create!(
    name: "Admin User",
    email: "admin@secondspark.com",
    password: "admin123",
    password_confirmation: "admin123",
    address: "123 Admin Street, Winnipeg, MB",
    role: "admin"
  )
  
  puts "管理员用户创建成功!"
  puts "邮箱: #{admin.email}"
  puts "密码: admin123"
end

puts
puts "管理员面板访问地址: http://127.0.0.1:9292/admin/products"
