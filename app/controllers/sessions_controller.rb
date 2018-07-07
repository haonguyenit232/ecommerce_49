class SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: :create

  private

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
