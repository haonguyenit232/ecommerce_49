class AddTotalPriceToOrderDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :order_details, :total_price, :decimal
  end
end
