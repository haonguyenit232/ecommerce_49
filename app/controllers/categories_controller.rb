class CategoriesController < ApplicationController
  before_action :load_categories, only: :index
  authorize_resource

  def index; end
end
