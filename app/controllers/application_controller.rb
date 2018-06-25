class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :admin_layout

  include SessionsHelper
  include CartsHelper

  def check_valid? id
    redirect_to root_path unless id
  end

  private

  def admin_layout
    if logged_in? && current_user.admin?
      Settings.admin_layout
    else
      Settings.app_layout
    end
  end
end
