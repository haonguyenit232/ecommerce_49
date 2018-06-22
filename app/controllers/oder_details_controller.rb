class OderDetailsController < ApplicationController
  before_action :load_order, only: %i(update destroy)

  def create
    @order = current_order
    @oder_detail = @order.oder_details.new order_item_params
    if @order.save
      session[:order_id] = @order.id
    else
      flash.now[:danger] = t "error_message"
    end
  end

  def update
    if @oder_detail.update_attributes order_item_params
      @oder_details = @order.oder_details
    else
      flash.now[:danger] = t "error_message"
    end
  end

  def destroy
    if @oder_detail.destroy
      @oder_details = @order.oder_details
    else
      flash.now[:danger] = t "error_message"
    end
  end

  private

  def order_item_params
    params.require(:oder_detail).permit :quantity, :product_id
  end

  def load_order
    @order = current_order
    @oder_detail = @order.oder_details.find_by id: params[:id]
    redirect_to products_path unless @oder_detail
  end
end
