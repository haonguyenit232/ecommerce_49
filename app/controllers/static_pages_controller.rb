class StaticPagesController < ApplicationController
  layout "statics_page"

  def home
    @hot_products = Product.hot_product_by_month Settings.home.limit
  end
end
