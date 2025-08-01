class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user # Product owner/seller
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :product_images, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :condition, presence: true

  enum condition: { 
    brand_new: 0, 
    like_new: 1, 
    good: 2, 
    fair: 3, 
    poor: 4 
  }

  scope :active, -> { where(active: true) }
  scope :in_stock, -> { where('quantity > 0') }
  scope :by_category, ->(category) { where(category: category) }
  scope :by_condition, ->(condition) { where(condition: condition) }

  def in_stock?
    quantity > 0
  end

  def formatted_price
    "$#{price.to_f}"
  end

  def average_rating
    return 0 if reviews.empty?
    reviews.average(:rating).round(1)
  end

  def review_count
    reviews.count
  end

  def condition_badge_class
    case condition
    when 'brand_new' then 'success'
    when 'like_new' then 'info' 
    when 'good' then 'primary'
    when 'fair' then 'warning'
    when 'poor' then 'danger'
    end
  end

  def main_image
    if image_url.present?
      image_url
    else
      # 默认占位图片
      'https://via.placeholder.com/400x300/6c757d/ffffff?text=No+Image'
    end
  end
end
