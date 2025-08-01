class OrdersController < ApplicationController
  before_action :require_login
  before_action :set_order, only: [:show]

  def index
    @orders = current_user.orders.order(created_at: :desc).limit(10)
  end

  def show
    @order_items = @order.order_items.includes(:product)
  end

  def new
    redirect_to cart_path, alert: 'Your cart is empty.' if current_cart&.empty?
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.total_amount = @current_cart.total_amount

    if @order.save
      # Create order items from cart items
      @current_cart.cart_items.each do |cart_item|
        @order.order_items.create!(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end

      # Clear the cart
      @current_cart.cart_items.destroy_all

      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:shipping_address, :billing_address)
  end
end
