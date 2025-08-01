#!/usr/bin/env ruby

require_relative 'config/environment'

puts "=== 字段验证检查 ==="
puts

# 检查Product模型的字段
puts "Product字段:"
Product.column_names.each { |col| puts "  - #{col}" }

puts
puts "User字段:"
User.column_names.each { |col| puts "  - #{col}" }

puts
puts "=== 测试产品访问 ==="
products = Product.limit(3)
products.each do |product|
  puts "产品 #{product.id}: #{product.name}"
  puts "  - 价格: #{product.formatted_price}"
  puts "  - 库存: #{product.quantity}"
  puts "  - 状态: #{product.condition.humanize}"
  puts "  - 图片: #{product.main_image.present? ? '有' : '无'}"
  puts
end

puts "=== 所有关键方法都可用 ✅ ==="
