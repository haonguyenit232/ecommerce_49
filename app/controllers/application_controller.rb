class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include CartsHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def valid_object object
    render file: "public/404.html", status: 404, layout: true unless object
  end

  def check_valid? id
    redirect_to root_path unless id
  end

  private

  def current_cart
    @producs_of_current_cart = Product.load_product_by_ids session[:cart].keys
  end

  def quantity_in_cart
    @producs_of_current_cart.each do |item|
      item.quantity_in_cart = session[:cart][item.id.to_s]
    end
  end

  def load_categories
    @categories = Category.all
  end

  def correct_rating_user
    @rating = Rating.find_by id: params[:id]
    unless @rating == (current_user.ratings.find_by id: params[:id])
      redirect_to root_path
    end
  end
end
