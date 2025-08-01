class HomeController < ApplicationController
  def index
    @featured_products = Product.active.in_stock.limit(8)
    @categories = Category.active
  end
end
