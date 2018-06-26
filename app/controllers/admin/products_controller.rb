module Admin
  class ProductsController < ApplicationController
    before_action :load_product, except: %i(index create new)

    def index
      @products = Product.includes(:category)
        .order_price.paginate page: params[:page], per_page: Settings.product_per_page
    end

    def show; end

    def new
      @product = Product.new
    end

    def edit; end

    def create
      @product = Product.new product_params
      if @product.save
        flash[:info] = t "admin.create_product"
        redirect_to @product
      else
        render :new
      end
    end

    def update
      if @product.update_attributes product_params
        flash[:success] = t "admin.update_product"
        redirect_to admin_products_path
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
      redirect_to admin_products_path
    end

    private

    def product_params
      params.require(:product).permit :title, :price, :description, :quantity, :image, :category_id
    end

    def load_product
      @product = Product.find_by id: params[:id]
      return if @product
      flash[:warning] = t ".product_nil"
      redirect_to root_path
    end
  end
end
