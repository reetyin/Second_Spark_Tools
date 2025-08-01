class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = 'customer' # Default role
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end

  def show
    @user = current_user
    redirect_to login_path unless user_signed_in?
  end

  def edit
    @user = current_user
    redirect_to login_path unless user_signed_in?
  end

  def update
    @user = current_user
    redirect_to login_path unless user_signed_in?
    
    if @user.update(user_update_params)
      redirect_to user_path(@user), notice: 'Profile updated successfully!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address)
  end

  def user_update_params
    # Allow updating without password if password fields are empty
    if params[:user][:password].blank?
      params.require(:user).permit(:name, :email, :address)
    else
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :address)
    end
  end
end
