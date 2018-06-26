class CartsController < ApplicationController

  before_action :logged_in_user, only: :index
  before_action :set_cart
  before_action :find_product, except: :index
  before_action :current_cart, :quantity_in_cart, only: :index

  def index; end

  def add_cart
    if session[:cart].key?(@product.id.to_s)
      session[:cart][@product.id.to_s] += Settings.quantity.default
    else
      session[:cart][@product.id.to_s] = Settings.quantity.default
    end
    update_decrement_product_quantity Settings.quantity.default
    respond_to do |format|
      format.html{render "static_pages/home"}
      format.json {}
      format.js
    end
  end

  def remove_cart
    if session[:cart].key?(@product.id.to_s)
      update_increment_product_quantity session[:cart][@product.id.to_s]
      session[:cart].delete @product.id.to_s
    end
    redirect_to carts_url
  end

  def update_hard_cart
    return render_validate_fail unless validate_quantity_cart @product, params[:quantity].to_i, true
    return return_quantity_is_zero if params[:quantity].to_i < Settings.quantity.default
    if session[:cart].key?(@product.id.to_s)
      current_quantity = session[:cart][@product.id.to_s]
      if current_quantity > params[:quantity].to_i
        update_increment_product_quantity current_quantity - params[:quantity].to_i
      elsif current_quantity < params[:quantity].to_i
        update_decrement_product_quantity params[:quantity].to_i - current_quantity
      end
      session[:cart][@product.id.to_s] = params[:quantity].to_i
    end
    redirect_to carts_url
  end

  private

  def validate_quantity_cart product, quantity, update_hard = false
    if update_hard || !session[:cart].key?(@product.id.to_s)
      product.quantity >= quantity
    else
      product.quantity >= (quantity + session[:cart][@product.id.to_s])
    end
  end

  def render_validate_fail
    flash[:danger] = t ".validate_quantity_fail"
    redirect_to carts_url
  end

  def return_quantity_is_zero
    flash[:danger] = t ".validate_quantity_is_zero"
    redirect_to carts_url
  end

  def find_product
    @product = Product.find_by id: params[:id_product]
    valid_object @product
  end

  def update_decrement_product_quantity quantity
    @product.decrement!(:quantity, quantity)
  end

  def update_increment_product_quantity quantity
    @product.increment!(:quantity, quantity)
  end
end
