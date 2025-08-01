class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.includes(:category).limit(20)
  end

  def show
  end

  def new
    @product = Product.new
    @categories = Category.active
  end

  def edit
    @categories = Category.active
  end

  def create
    @product = current_user.products.build(product_params)
    @categories = Category.active

    if @product.save
      redirect_to admin_product_path(@product), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    @categories = Category.active
    
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'Product was successfully deleted.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :active, :category_id, :condition, :image_url)
  end
end
