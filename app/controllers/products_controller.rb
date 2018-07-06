class ProductsController < ApplicationController
  before_action :load_product, only: :show
  before_action :load_products, only: :filter_product
  after_action :load_comments, only: :show


  def index
    # @products = Product.order_price
    #   .paginate page: params[:page], per_page: Settings.product_per_page
    @categories =  Category.includes(:subcategories).order_name
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def show
    @rating = current_user.ratings.find_by product_id: @product.id if
      user_signed_in? && current_user.rating?(@product)
  end

  def filter_product; end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:warning] = t ".oproduct_nil"
    redirect_to root_path
  end

  def load_products
    case
    when params[:cat_id]
      @products = Product.by_category params[:cat_id]
    when params[:sort_by]
      @products  = Product.order_name params[:sort_by].to_sym
    else params[:price_min][:value] && params[:price_max][:value]
      @products  = Product.min_max_price params[:price_min][:value], params[:price_max][:value]
    end
  end

  def load_comments
    @comments = @product.comments.includes(:users)
      .paginate page: params[:page], per_page: Settings.paginate.comment_perpage
    @comment = current_user.comments.build if user_signed_in?
  end
end
