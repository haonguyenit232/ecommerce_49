class AdminController < ApplicationController
  before_action :ensure_admin!
  layout "admin"

  private

    def ensure_admin!
      return if current_user.admin?
      flash[:danger] = t "flash.not_permitted"
      redirect_to root_path
    end
end
