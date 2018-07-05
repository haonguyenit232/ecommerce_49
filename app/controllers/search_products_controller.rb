class SearchProductsController < ApplicationController
  def index
    @products = @search.result(distinct: true)
  end
end
