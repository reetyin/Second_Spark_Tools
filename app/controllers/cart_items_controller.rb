class CartItemsController < ApplicationController
  before_action :require_login

  def create
    @product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    
    current_cart.add_product(@product, quantity)
    
    redirect_to cart_path, notice: 'Item added to cart!'
  end

  def update
    @cart_item = current_cart.cart_items.find(params[:id])
    
    if @cart_item.update(quantity: params[:quantity])
      redirect_to cart_path, notice: 'Cart updated!'
    else
      redirect_to cart_path, alert: 'Unable to update cart.'
    end
  end

  def destroy
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.destroy
    
    redirect_to cart_path, notice: 'Item removed from cart.'
  end
end
