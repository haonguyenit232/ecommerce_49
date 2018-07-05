module Admin
  class OrdersController < AdminController
    before_action :load_order, only: :update

    def index
      @orders = Order.status(params[:status])
        .paginate page: params[:page], per_page: Settings.product_per_page
    end

    def update
      ActiveRecord::Base.transaction do
        begin
          if @order.send("#{params[:order][:status]}!")
            flash[:danger] = t "sucess_msg"
            redirect_to admin_orders_path
          end
        rescue
          flash[:danger] = t "error_message"
          render :index
        end
      end
    end

    private

    def load_order
      @order = Order.find_by id: params[:id]
      return if @order
      flash[:danger] = t "error_message"
      redirect_to admin_root_path
    end
  end
end
