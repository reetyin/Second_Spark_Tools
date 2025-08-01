class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.active.includes(:category, :reviews)
    @products = @products.by_category(params[:category_id]) if params[:category_id].present?
    @products = @products.by_condition(params[:condition]) if params[:condition].present?
    @products = @products.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?
    @products = @products.limit(12)
    
    @categories = Category.active
    @conditions = Product.conditions.keys
  end

  def show
    @related_products = Product.active.where(category: @product.category)
                              .where.not(id: @product.id)
                              .limit(4)
    @reviews = @product.reviews.includes(:user).order(created_at: :desc)
    @new_review = Review.new if user_signed_in?
  end

  private

  def set_product
    @product = Product.active.find(params[:id])
  end
end
