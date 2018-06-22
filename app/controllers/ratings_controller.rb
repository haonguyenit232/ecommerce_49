class RatingsController < ApplicationController
  before_action :load_rating, only: :update
  before_action :load_product

  def create
    @rating = Rating.new rating_params
    if @rating.save
      flash[:success] = t("rating.thanks_for_rating")
      @product.update_rating_average
    else
      flash[:danger] = t("rating.retry")
    end
    redirect_to product_url params[:rating][:product_id]
  end

  def update
    if @rating.update_attributes rating_params
      flash[:success] = t "rating.thanks_for_rating"
      @product.update_rating_average
    else
      flash[:danger] = t "rating.retry"
    end
    redirect_to product_url params[:rating][:product_id]
  end

  private

  def load_rating
    @rating = Rating.find_by id: params[:id]
    return if @rating
    flash[:danger] = t "rating.rating_not_found"
    redirect_to root_url
  end

  def load_product
    @product = Product.find_by id: params[:rating][:product_id]
    return if @product
    flash[:danger] = t "alert.product_not_found"
    redirect_to root_url
  end

  def rating_params
    params.require(:rating).permit :starts, :product_id, :user_id
  end
end
