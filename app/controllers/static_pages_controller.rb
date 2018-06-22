class StaticPagesController < ApplicationController
  layout "statics_page"

  def home
    @products = Product.name_sort.limit Settings.limit_list
    @newest_products = Product.newest_product.limit Settings.limit_list
    @recommended_products = Product.recommended_product.limit Settings.recommended_limit
  end
end
