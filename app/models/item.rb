class Item
  attr_accessor :product_id, :title, :quantity, :price, :image

  def initialize product_id, title, quantity, price, image
    @product_id = product_id
    @quantity = quantity
    @price = price
    @image = image
    @title = title
  end

end
