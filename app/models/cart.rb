class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def total_items
    cart_items.sum(:quantity)
  end

  def total_amount
    cart_items.sum { |item| item.product.price * item.quantity }
  end

  def add_product(product, quantity = 1)
    existing_item = cart_items.find_by(product: product)
    
    if existing_item
      existing_item.update(quantity: existing_item.quantity + quantity)
    else
      cart_items.create(product: product, quantity: quantity)
    end
  end

  def empty?
    cart_items.empty?
  end
end
