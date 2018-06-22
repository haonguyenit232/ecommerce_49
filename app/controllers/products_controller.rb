class ProductsController < ApplicationController
  before_action :loads_product, except: %i(index create new)

  def index
    @products = Product.order_price.paginate page: params[:page], per_page: Settings.product_per_page
    @order_detail = current_order.oder_details.new
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:info] = t "user_mailer.create_product"
      redirect_to @product
    else
      render :new
    end
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "user_mailer.update_product"
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t ".product_deleted_msg"
    else
      flash[:danger] = t ".product_delete_err_msg"
    end
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit :title, :price, :description, :quantity, :image, :category_id
  end

  def loads_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:warning] = t ".oproduct_nil"
    redirect_to root_path
  end

  def able_to_rating
    return unless logged_in?
    @rating = @current_user.ratings.find_by product_id: @product.id
    @rating ||= Rating.new
  end
end
