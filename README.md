# Winnipeg Electronics Store - Ruby on Rails E-commerce Project

## Project Description

This is a comprehensive Ruby on Rails e-commerce application for Winnipeg Electronics Store, a fictional electronics retailer based in Winnipeg, Manitoba. The store specializes in computers, electronics components, and accessories, serving both individual customers and small businesses in the Winnipeg area.

### Business Background

**Company:** Winnipeg Electronics Store  
**Founded:** 2008 (15+ years in business)  
**Employees:** 12 full-time staff members  
**Location:** 123 Portage Avenue, Winnipeg, MB  

**Current Business Model:**
- Physical retail store in downtown Winnipeg
- Wholesale to local computer repair shops
- Corporate sales to small and medium businesses
- Limited online presence (information only)

**Target Demographic:**
- Tech enthusiasts and gamers (ages 18-35)
- Small business owners needing office equipment
- Students and professionals requiring laptops and accessories
- Local computer repair shops and resellers

**Products:**
- Laptops and desktop computers
- Computer components (processors, graphics cards, RAM, storage)
- Accessories (keyboards, mice, webcams, cables)
- Tablets and mobile devices

## Database Structure

### Tables and Relationships

#### Users Table
- **Purpose:** Store customer and admin account information
- **Columns:**
  - `id` (Primary Key)
  - `email` (String, Unique)
  - `encrypted_password` (String)
  - `first_name` (String)
  - `last_name` (String)
  - `phone` (String)
  - `address` (Text)
  - `city` (String)
  - `province` (String)
  - `postal_code` (String)
  - `role` (Integer, Enum: customer=0, admin=1)
  - Devise fields for authentication

#### Categories Table
- **Purpose:** Organize products into logical groups for easier browsing
- **Columns:**
  - `id` (Primary Key)
  - `name` (String, Unique)
  - `description` (Text)
  - `active` (Boolean, Default: true)

#### Products Table
- **Purpose:** Store product information including pricing and inventory
- **Columns:**
  - `id` (Primary Key)
  - `name` (String)
  - `description` (Text)
  - `price` (Decimal, precision: 10, scale: 2)
  - `stock_quantity` (Integer)
  - `sku` (String, Unique)
  - `active` (Boolean)
  - `category_id` (Foreign Key to Categories)

#### Orders Table
- **Purpose:** Track customer orders and their status
- **Columns:**
  - `id` (Primary Key)
  - `order_number` (String, Unique)
  - `user_id` (Foreign Key to Users)
  - `total_amount` (Decimal, precision: 10, scale: 2)
  - `status` (Integer, Enum: pending, confirmed, processing, shipped, delivered, cancelled)
  - `shipping_address` (Text)
  - `billing_address` (Text)
  - `shipped_at` (DateTime)
  - `delivered_at` (DateTime)

#### Order Items Table
- **Purpose:** Store individual products within each order with historical pricing
- **Columns:**
  - `id` (Primary Key)
  - `order_id` (Foreign Key to Orders)
  - `product_id` (Foreign Key to Products)
  - `quantity` (Integer)
  - `price` (Decimal, precision: 10, scale: 2) - Historical price at time of order

#### Carts Table
- **Purpose:** Maintain shopping cart state for logged-in users
- **Columns:**
  - `id` (Primary Key)
  - `user_id` (Foreign Key to Users)

#### Cart Items Table
- **Purpose:** Store products temporarily added to shopping cart
- **Columns:**
  - `id` (Primary Key)
  - `cart_id` (Foreign Key to Carts)
  - `product_id` (Foreign Key to Products)
  - `quantity` (Integer)

#### Product Images Table
- **Purpose:** Store multiple images for each product
- **Columns:**
  - `id` (Primary Key)
  - `product_id` (Foreign Key to Products)
  - `image_url` (String)
  - `alt_text` (String)
  - `position` (Integer)

### Associations

- **User** has_many Orders, has_one Cart, has_many CartItems through Cart
- **Category** has_many Products
- **Product** belongs_to Category, has_many OrderItems, has_many CartItems, has_many ProductImages
- **Order** belongs_to User, has_many OrderItems
- **OrderItem** belongs_to Order and Product
- **Cart** belongs_to User, has_many CartItems
- **CartItem** belongs_to Cart and Product
- **ProductImage** belongs_to Product

### Key Features Addressed

✅ **Customer Order Tracking:** Users can view their order history and current order status  
✅ **Multiple Product Ordering:** Customers can order different products in a single transaction  
✅ **Quantity Management:** Support for ordering specific quantities of each product  
✅ **Historical Pricing:** OrderItems table stores price at time of purchase, preserving order totals even when product prices change  

## Setup Instructions

1. **Install Dependencies:**
   ```bash
   bundle install
   ```

2. **Database Setup:**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

3. **Start the Server:**
   ```bash
   rails server
   ```

4. **Default Users:**
   - Admin: `admin@winnipegelectronics.com` / `password123`
   - Customer: `customer@example.com` / `password123`

## Features

### Customer Features
- User registration and authentication
- Browse products by category
- Search functionality
- Shopping cart management
- Order placement and tracking
- User profile management

### Admin Features
- Product management (CRUD operations)
- Order management and status updates
- Inventory tracking
- Category management

### Technical Features
- Responsive Bootstrap design
- User authentication with Devise
- Role-based authorization
- Image handling for products
- Pagination for large datasets
- Form validation and error handling

## Technology Stack

- **Ruby on Rails 7.0**
- **PostgreSQL** (Database)
- **Bootstrap 5** (Frontend styling)
- **Devise** (Authentication)
- **Kaminari** (Pagination)
- **CarrierWave** (Image uploads)
- **Money-Rails** (Currency handling)

## Future Enhancements

- Payment integration (Stripe/PayPal)
- Email notifications for orders
- Product reviews and ratings
- Wishlist functionality
- Advanced search with filters
- Inventory alerts for low stock
- Customer support chat system
- Multi-language support
