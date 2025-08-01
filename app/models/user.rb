class User < ApplicationRecord
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable

  has_secure_password

  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :cart_items, through: :cart
  has_many :products, dependent: :destroy # Products they're selling
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :address, presence: true

  enum role: { customer: 0, admin: 1 }

  def current_cart
    cart || create_cart
  end
end
