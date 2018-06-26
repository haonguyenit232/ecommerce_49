module Admin
  class CategoriesController < ApplicationController
    before_action :load_category, except: %i(index create new)

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
        flash[:info] = t "create_cate"
        redirect_to admin_categories_path
      else
        render :new
      end
    end

    def update
      if @category.update_attributes category_params
        flash[:success] = t "update_cate"
        redirect_to @category
      else
        render :new
      end
    end

    def destroy
      if @category.destroy
        flash[:success] = t ".category_deleted_msg"
      else
        flash[:danger] = t ".category_delete_err_msg"
      end
      redirect_to admin_categories_path
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
  end
end
