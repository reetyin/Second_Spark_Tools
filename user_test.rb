#!/usr/bin/env ruby

require_relative 'config/environment'

puts "=== Second Spark Tools - 用户功能测试 ==="
puts

# 测试用户登录和个人资料编辑
test_user = User.find_by(email: 'test@test.com')
if test_user
  puts "✅ 测试用户存在"
  puts "   邮箱: #{test_user.email}"
  puts "   密码: test123"
  puts "   个人资料页面: http://127.0.0.1:9292/users/#{test_user.id}"
  puts "   编辑个人资料: http://127.0.0.1:9292/users/#{test_user.id}/edit"
else
  puts "❌ 测试用户不存在"
end

puts

# 管理员用户
admin_user = User.admin.first
if admin_user
  puts "✅ 管理员用户存在"
  puts "   邮箱: #{admin_user.email}"
  puts "   密码: admin123"
  puts "   管理员面板: http://127.0.0.1:9292/admin/products"
else
  puts "❌ 管理员用户不存在"
end

puts

puts "=== 功能说明 ==="
puts "1. 用户注册: http://127.0.0.1:9292/signup"
puts "2. 用户登录: http://127.0.0.1:9292/login"
puts "3. 个人资料: 登录后点击导航栏中的 'Profile'"
puts "4. 编辑个人资料: 在个人资料页面点击 'Edit Profile'"
puts "5. 管理员面板: 管理员登录后可在导航栏看到 'Admin' 下拉菜单"
