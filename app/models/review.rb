class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { minimum: 10 }
  validates :user_id, uniqueness: { scope: :product_id, message: "You can only review a product once" }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_rating, ->(rating) { where(rating: rating) }

  def rating_stars
    "★" * rating + "☆" * (5 - rating)
  end
end
