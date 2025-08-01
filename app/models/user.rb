class User < ApplicationRecord
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable

  has_secure_password validations: false

  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, length: { minimum: 6 }, allow_blank: true, on: :update
  validates :password_confirmation, presence: true, on: :create
  validates :password_confirmation, presence: true, if: :password_present?, on: :update

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

  private

  def password_present?
    password.present?
  end
end
