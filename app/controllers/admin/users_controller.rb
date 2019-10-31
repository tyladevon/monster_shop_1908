class Admin::UsersController < Admin::BaseController

  def show
    if current_user.admin?
      @user = User.find(params[:id])
    end
  end

  def index
    @users = User.all
  end
end
