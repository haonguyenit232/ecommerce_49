class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :products, through: :order_details

  enum status: [:deleted, :pending, :shipped]
  after_save :update_quantity_product

  private

  def update_quantity_product
    order = Order.find_by id: self.id
    items = order.order_details
    items.each do |od|
      product = Product.find_by id: od.product_id
      quantity_update = product.quantity.to_i - od.quantity.to_i
      Product.where(:id => od.product_id).update_all(:quantity => quantity_update)
    end
  end
end
