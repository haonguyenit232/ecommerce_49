class OrdersController < ApplicationController
  before_action :load_orders, only: :index
  before_action :check_cart_empty, only: :create
  before_action :current_cart, :quantity_in_cart, only: %i(new create)

  include OrdersHelper

  def index; end

  def new
    @order = Order.new
  end

  def create
    ActiveRecord::Base.transaction do
      @order = Order.new order_params
      if @order.save
        create_ordersdetails session[:cart], @order
        UserMailer.order_mail(current_user, @order).deliver_now
        create_order_success
      end
    end
  rescue
    flash[:danger] = t "order_fail"
    render :new
  end

  private

  def order_params
    params.require(:order).permit :user_id, :total, :name, :phone, :address
  end

  def redirect_if_cart_empty
    flash[:danger] = t "empty_cart"
    redirect_to carts_path
  end

  def load_orders
    @orders = current_user.orders.newest
      .paginate page: params[:page], per_page: Settings.paginate.per_page
  end

  def check_cart_empty
    return redirect_if_cart_empty if (session[:cart].empty? || session[:cart].size == Settings.quantity.zero)
  end

  def create_order_success
    flash[:success] = t "success_msg"
    session[:cart] = {}
    redirect_to root_path
  end
end