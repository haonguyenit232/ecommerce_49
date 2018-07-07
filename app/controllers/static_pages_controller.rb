class StaticPagesController < ApplicationController
  layout "statics_page"

  def home
    @lastest_products = Product.lastest_product Settings.home.limit
    @hot_products = Product.hot_product_by_month Settings.home.limit
  end
end
