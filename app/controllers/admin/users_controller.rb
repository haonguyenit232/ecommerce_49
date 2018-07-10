module Admin
  class UsersController < AdminController
    load_and_authorize_resource param_method: :user_params

    def index
      @users = User.newest.paginate page: params[:page], per_page: Settings.user_per_page
    end

    def new; end

    def show; end

    def create
      @user = User.new user_params
      if @user.save
        log_in @user
        flash[:info] = t "user_mailer.check_alert"
        redirect_to root_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @user.update_attributes user_update_params
        flash[:success] = t "user_mailer.updated"
        redirect_to @user
      else
        render :new
      end
    end

    def destroy
      if @user.destroy
        flash[:success] = t ".user_deleted_msg"
      else
        flash[:danger] = t ".user_delete_err_msg"
      end
      redirect_to users_path
    end

    private

    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    def user_update_params
      params.require(:user).permit :name, :email, :address, :phone
    end
  end
end
