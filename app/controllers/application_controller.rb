class ApplicationController < ActionController::Base
  # Remove authentication for now to see the app working
  # before_action :authenticate_user!, except: [:index, :show]
  before_action :current_cart

  # Make these methods available to views
  helper_method :current_user, :user_signed_in?, :current_cart

  protected

  # Real authentication system
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def require_login
    unless user_signed_in?
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied. Admin privileges required.'
    end
  end

  def current_cart
    return nil unless current_user
    @current_cart ||= current_user.current_cart
  end
end
