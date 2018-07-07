module Admin
  class CategoriesController < AdminController
    before_action :load_category, except: %i(index create new)
    before_action :check_parent, only: :update
    authorize_resource

    def index
      @categories = Category.includes(:subcategories)
        .order_name.paginate page: params[:page], per_page: Settings.cate_per_page
    end

    def show; end

    def new
      @category = Category.new
    end

    def edit; end

    def create
      @category = Category.new category_params
      if @category.save
        flash[:info] = t "sucess_msg"
        redirect_to admin_categories_path
      else
        render :new
      end
    end

    def update
      if @category.update_attributes category_params
        flash[:success] = t "sucess_msg"
        redirect_to admin_categories_path
      else
        render :new
      end
    end

    def destroy
      if @category.products.size > 0
        flash[:danger] = t("category_delete_err_msg",
          number: @category.products.size)
      else
        if @category.destroy
          flash[:success] = t ".category_deleted_msg"
        else
          flash[:danger] = t ".category_delete_err_msg"
        end
      end
      redirect_to new_admin_category_path
    end

    private

    def category_params
      params.require(:category).permit :name, :parent_category
    end

    def load_category
      @category = Category.find_by id: params[:id]
      return if @category
      flash[:warning] = t ".cate_nil"
    end

    def check_parent
      return unless @category.id == params[:category][:parent_category].to_i
      flash[:danger] = t "error_message"
      redirect_to edit_admin_category_path @category
    end
  end
end
