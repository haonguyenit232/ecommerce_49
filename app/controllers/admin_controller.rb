class AdminController < ApplicationController
  before_action :is_admin
  layout "admin"
end
