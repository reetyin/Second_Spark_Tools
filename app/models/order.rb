class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :order_number, presence: true, uniqueness: true
  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true

  enum status: { 
    pending: 0, 
    confirmed: 1, 
    processing: 2, 
    shipped: 3, 
    delivered: 4, 
    cancelled: 5 
  }

  before_create :generate_order_number

  def total_items
    order_items.sum(:quantity)
  end

  def calculate_total
    order_items.sum { |item| item.price * item.quantity }
  end

  private

  def generate_order_number
    self.order_number = "ORD-#{Time.current.strftime('%Y%m%d')}-#{SecureRandom.hex(4).upcase}"
  end
end
