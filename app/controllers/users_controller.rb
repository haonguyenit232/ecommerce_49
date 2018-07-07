class UsersController < Devise::RegistrationsController

  private

  def update_resource resource, params
    resource.update_without_password params
  end

  def sign_up_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def account_update_params
    params.require(:user).permit :name, :email, :address, :phone
  end
end
