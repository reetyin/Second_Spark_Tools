# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🔧 Seeding Second Spark Tools database..."

# 清除现有数据
puts "Clearing existing data..."
Review.destroy_all
ProductImage.destroy_all
CartItem.destroy_all
Cart.destroy_all
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all

# 创建分类
puts "Creating categories..."
categories = [
  {
    name: "Power Tools",
    description: "Electric and battery-powered tools for heavy-duty work",
    active: true
  },
  {
    name: "Hand Tools", 
    description: "Manual tools for precision work and general use",
    active: true
  },
  {
    name: "Accessories",
    description: "Tool accessories, bits, blades and attachments", 
    active: true
  }
]

created_categories = categories.map do |cat_data|
  Category.create!(cat_data)
end

puts "Created #{created_categories.count} categories"

# 创建用户
puts "Creating users..."
users_data = [
  {
    name: "John Smith",
    email: "john@example.com", 
    password: "password123",
    address: "123 Admin St, Winnipeg, MB R3B 2G3",
    role: "admin"
  },
  {
    name: "Mike Tool Seller",
    email: "mike@toolseller.com",
    password: "password123", 
    address: "456 Seller Ave, Winnipeg, MB R2W 3B6",
    role: "customer"
  },
  {
    name: "Sarah Builder",
    email: "sarah@builder.com",
    password: "password123",
    address: "789 Builder Blvd, Winnipeg, MB R3C 1A1",
    role: "customer"
  },
  {
    name: "Tom Contractor", 
    email: "tom@contractor.com",
    password: "password123",
    address: "321 Contractor Ct, Winnipeg, MB R2V 4T5",
    role: "customer"
  },
  {
    name: "Lisa Workshop",
    email: "lisa@workshop.com",
    password: "password123",
    address: "654 Workshop Way, Winnipeg, MB R3T 2N2",
    role: "customer"
  }
]

created_users = users_data.map do |user_data|
  User.create!(user_data)
end

puts "Created #{created_users.count} users"

# 二手工具图片URLs (使用免费的Unsplash图片)
tool_images = [
  "https://images.unsplash.com/photo-1572981779307-38b8cabb2407?w=400&h=300&fit=crop", # 电钻
  "https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=400&h=300&fit=crop", # 工具
  "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=300&fit=crop", # 锤子
  "https://images.unsplash.com/photo-1609205387707-91e3ca6c6b50?w=400&h=300&fit=crop", # 扳手
  "https://images.unsplash.com/photo-1609205387660-3f035e5f2474?w=400&h=300&fit=crop", # 螺丝刀
  "https://images.unsplash.com/photo-1609205387470-ee30b21faed1?w=400&h=300&fit=crop", # 锯子
  "https://images.unsplash.com/photo-1609205387644-86ecaf1c2d50?w=400&h=300&fit=crop", # 钳子
  "https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=400&h=300&fit=crop", # 电动工具
  "https://images.unsplash.com/photo-1533090161767-e6ffed986c88?w=400&h=300&fit=crop", # 工具箱
  "https://images.unsplash.com/photo-1609205387643-86ecaf1c2d51?w=400&h=300&fit=crop"  # 配件
]

# 创建产品
puts "Creating products..."

power_tools_data = [
  {
    name: "DEWALT 20V MAX Cordless Drill",
    description: "Powerful 20V cordless drill with 2-speed transmission. Includes battery and charger. Light wear on housing but works perfectly.",
    price: 89.99,
    condition: "good",
    category: created_categories[0], # Power Tools
    user: created_users[1], # Mike Tool Seller
    active: true,
    quantity: 2
  },
  {
    name: "Milwaukee M12 Impact Driver", 
    description: "Compact M12 impact driver, great for tight spaces. Some scratches but excellent performance. Battery not included.",
    price: 65.00,
    condition: "fair", 
    category: created_categories[0],
    user: created_users[2], # Sarah Builder
    active: true,
    quantity: 1
  },
  {
    name: "Makita Circular Saw 7-1/4\"",
    description: "Professional-grade circular saw with carbide blade. Minimal use, like new condition. Perfect for framing and cutting.",
    price: 145.00,
    condition: "like_new",
    category: created_categories[0],
    user: created_users[3], # Tom Contractor  
    active: true,
    quantity: 1
  },
  {
    name: "Black & Decker Jigsaw",
    description: "Electric jigsaw with variable speed control. Good working condition with normal wear. Includes several blades.",
    price: 35.99,
    condition: "good",
    category: created_categories[0],
    user: created_users[1],
    active: true,
    quantity: 3
  },
  {
    name: "Ryobi Angle Grinder 4.5\"",
    description: "Powerful angle grinder for cutting and grinding. Heavy use but still functional. Good for hobbyists.",
    price: 42.50,
    condition: "fair",
    category: created_categories[0], 
    user: created_users[4], # Lisa Workshop
    active: true,
    quantity: 2
  }
]

hand_tools_data = [
  {
    name: "Craftsman Socket Set 42-Piece",
    description: "Complete socket set with ratchet and extension bars. All pieces present. Some wear on chrome finish.",
    price: 28.99,
    condition: "good",
    category: created_categories[1], # Hand Tools
    user: created_users[2],
    active: true,
    quantity: 1
  },
  {
    name: "Stanley Hammer 16oz Claw",
    description: "Classic claw hammer with wood handle. Light use, excellent grip. Perfect for general construction.",
    price: 12.99,
    condition: "like_new",
    category: created_categories[1],
    user: created_users[3],
    active: true,
    quantity: 4
  },
  {
    name: "Klein Tools Wire Strippers",
    description: "Professional electrician's wire strippers. Heavy use but still precise. Essential for electrical work.",
    price: 18.50,
    condition: "fair",
    category: created_categories[1],
    user: created_users[1],
    active: true,
    quantity: 2
  },
  {
    name: "Channellock Pliers Set",
    description: "Set of 3 pliers: needle nose, standard, and diagonal cutters. Good working condition with minor rust spots.",
    price: 24.99,
    condition: "good",
    category: created_categories[1],
    user: created_users[4],
    active: true,
    quantity: 1
  },
  {
    name: "Starrett Combination Square",
    description: "Precision combination square for layout and measurement. Excellent accuracy, minimal wear.",
    price: 45.00,
    condition: "like_new",
    category: created_categories[1],
    user: created_users[2],
    active: true,
    quantity: 1
  }
]

accessories_data = [
  {
    name: "Drill Bit Set 29-Piece",
    description: "Complete drill bit set for wood, metal, and masonry. Most bits in good condition, a few show wear.",
    price: 15.99,
    condition: "good",
    category: created_categories[2], # Accessories
    user: created_users[1],
    active: true,
    quantity: 5
  },
  {
    name: "Circular Saw Blades Pack",
    description: "Pack of 3 carbide-tipped blades for circular saws. Various tooth counts. Light use, sharp edges.",
    price: 22.50,
    condition: "like_new",
    category: created_categories[2],
    user: created_users[3],
    active: true,
    quantity: 2
  },
  {
    name: "Sandpaper Assortment",
    description: "Mixed grits sandpaper pack - 80, 120, 220, 320 grit. About 20 sheets total. Good for various projects.",
    price: 8.99,
    condition: "brand_new",
    category: created_categories[2],
    user: created_users[4],
    active: true,
    quantity: 10
  },
  {
    name: "Extension Cord 50ft Heavy Duty",
    description: "Professional grade extension cord, weather resistant. Some scuff marks but excellent conductivity.",
    price: 32.00,
    condition: "good",
    category: created_categories[2],
    user: created_users[2],
    active: true,
    quantity: 3
  }
]

all_products_data = power_tools_data + hand_tools_data + accessories_data

created_products = []
all_products_data.each_with_index do |product_data, index|
  product = Product.create!(product_data)
  created_products << product
  
  # 为每个产品添加图片
  image_url = tool_images[index % tool_images.length]
  ProductImage.create!(
    product: product,
    image_url: image_url,
    alt_text: "#{product.name} - #{product.condition} condition",
    position: 0
  )
  
  print "."
end

puts "\nCreated #{created_products.count} products with images"

# 创建购物车
puts "Creating sample carts..."
created_users[1..3].each do |user|
  cart = Cart.create!(user: user)
  
  # 为每个购物车添加1-3个随机商品
  sample_products = created_products.sample(rand(1..3))
  sample_products.each do |product|
    CartItem.create!(
      cart: cart,
      product: product,
      quantity: rand(1..2)
    )
  end
end

puts "Created sample carts with items"

# 创建一些订单
puts "Creating sample orders..."
3.times do |i|
  user = created_users[i + 1]
  
  # 先选择产品并计算总价
  order_products = created_products.sample(rand(1..3))
  total = 0
  order_items_data = []
  
  order_products.each do |product|
    quantity = rand(1..2)
    price = product.price
    
    order_items_data << {
      product: product,
      quantity: quantity,
      price: price
    }
    
    total += price * quantity
  end
  
  # 创建订单
  order = Order.create!(
    user: user,
    order_number: "SST-#{Date.current.strftime('%Y%m%d')}-#{1001 + i}",
    total_amount: total,
    status: ['pending', 'processing', 'shipped'].sample,
    shipping_address: "#{123 + i} Main St, Winnipeg, MB R3C 1A1",
    billing_address: "#{123 + i} Main St, Winnipeg, MB R3C 1A1"
  )
  
  # 创建订单项
  order_items_data.each do |item_data|
    OrderItem.create!(
      order: order,
      product: item_data[:product], 
      quantity: item_data[:quantity],
      price: item_data[:price]
    )
  end
end

puts "Created sample orders"

# 创建商品评价
puts "Creating product reviews..."
review_comments = [
  "Great tool, exactly as described. Fast shipping!",
  "Good value for money. Tool works perfectly despite some wear.",
  "Excellent condition, better than expected. Highly recommend!",
  "Fair price for the condition. Tool does the job well.",
  "Quick delivery and good communication from seller.",
  "Tool is in good working order. Some cosmetic wear but functions great.",
  "Perfect for my workshop. Good quality used tool.",
  "Exactly what I needed for my project. Good deal!",
  "Great seller, tool arrived quickly and as described.",
  "Good tool at a fair price. Would buy from this seller again."
]

created_products.each do |product|
  # 为每个产品创建1-3个评价，确保每个用户只评价一次
  available_reviewers = created_users.reject { |u| u == product.user }
  reviewers = available_reviewers.sample(rand(1..3))
  
  reviewers.each do |reviewer|
    Review.create!(
      user: reviewer,
      product: product,
      rating: rand(3..5), # 评分3-5星
      comment: review_comments.sample
    )
  end
end

puts "Created product reviews"

puts "\n🎉 Database seeded successfully!"
puts "\n📊 Summary:"
puts "- Categories: #{Category.count}"
puts "- Users: #{User.count}" 
puts "- Products: #{Product.count}"
puts "- Product Images: #{ProductImage.count}"
puts "- Orders: #{Order.count}"
puts "- Order Items: #{OrderItem.count}"
puts "- Reviews: #{Review.count}"
puts "- Carts: #{Cart.count}"
puts "- Cart Items: #{CartItem.count}"

puts "\n🔑 Test Login Credentials:"
puts "Admin: john@example.com / password123"
puts "Customer: mike@toolseller.com / password123"
puts "Customer: sarah@builder.com / password123"

puts "\n🛠️ Ready to start Second Spark Tools!"
