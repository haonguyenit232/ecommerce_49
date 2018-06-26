module CartsHelper

  def set_cart
    @cart = session[:cart] ||= {}
  end

  def sum_total_price_of_cart
    @producs_of_current_cart.map do |product|
      (product.quantity_in_cart * product.price).to_i
    end
  end

  def is_empty_cart?
    session[:cart].nil? || session[:cart].empty?
  end
end
