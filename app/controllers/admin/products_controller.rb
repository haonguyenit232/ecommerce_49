module Admin
  class ProductsController < AdminController
    before_action :load_product, only: :index
    before_action :find_product, except: %i(index new create import)
    authorize_resource

    def index
      @products = Product.includes(:category)
        .order_price.paginate page: params[:page], per_page: Settings.product_per_page
      respond_to do |format|
        format.html
        format.csv { send_data Product.to_csv, filename: "products-#{Date.today}.csv" }
    end

    def import
      csv_text = File.read(params[:file].tempfile)
      data = ProductServices::ImportDataProduct.new()
      data.call(csv_text)
      if data.errors.present?
        redirect_to admin_products_path, :notice => data.errors.join('<br>')
      else
        redirect_to admin_products_path, :notice => "You have successfully imported."
      end
    end

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
        flash[:success] = t "sucess_msg"
        redirect_to admin_products_path
      else
        render :edit
      end
    end

    def destroy
      if @product.order_details.size > 0
        flash[:danger] = t("delete_product_error",
          number: @product.order_details.size)
      else
        if @product.destroy
          flash[:success] =  "delete_product_success"
        else
          flash[:danger] =  "delete_product_fail"
        end
      end
      redirect_to admin_products_path
    end


    private

    def product_params
      params.require(:product).permit :name, :price, :description, :quantity, :image, :category_id
    end

    def find_product
      @product = Product.find_by id: params[:id]
      valid_object @product
    end

    def load_product
      @products = Product.active.order_by_id
        .paginate page: params[:page], per_page: Settings.product_per_page
    end

    def load_categories
      @categories = Category.order_name
    end
  end
end
