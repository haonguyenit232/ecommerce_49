class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    @products = Product.order_price
      .paginate page: params[:page], per_page: Settings.product_per_page
  end

  def show
    @rating = current_user.ratings.find_by product_id: @product.id if
      logged_in? && current_user.rating?(@product)
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:warning] = t ".oproduct_nil"
    redirect_to root_path
  end
end
