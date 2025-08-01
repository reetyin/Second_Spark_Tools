#!/usr/bin/env ruby

require_relative 'config/environment'

puts "=== Second Spark Tools - 系统验证 ==="
puts

puts "1. 数据库连接: #{ActiveRecord::Base.connected? ? '✅' : '❌'}"
puts "2. 产品数量: #{Product.count}"
puts "3. 用户数量: #{User.count}"
puts "4. 管理员用户: #{User.admin.count}"
puts "5. 分类数量: #{Category.count}"

puts
puts "=== 可用的测试URL ==="
puts "首页: http://127.0.0.1:9292/"
puts "产品列表: http://127.0.0.1:9292/products"
puts "第一个产品详情: http://127.0.0.1:9292/products/#{Product.first&.id}"
puts "登录页面: http://127.0.0.1:9292/login"
puts "注册页面: http://127.0.0.1:9292/signup"
puts "管理员面板: http://127.0.0.1:9292/admin/products"

puts
puts "=== 测试账户 ==="
admin = User.admin.first
if admin
  puts "管理员账户: #{admin.email}"
  puts "管理员密码: admin123"
else
  puts "❌ 没有找到管理员账户"
end

puts
puts "=== 产品样例 ==="
Product.limit(3).each do |product|
  puts "- #{product.name} (${product.price}) - #{product.condition.humanize}"
end
