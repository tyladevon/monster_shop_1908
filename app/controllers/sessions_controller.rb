class SessionsController < ApplicationController
  def new
    if current_user
      flash[:success] = "You are already logged in #{current_user.name}"
      redirect_user 
    end
  end

  def create
    user = User.find_by(email: login_params[:email])
    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      if user.reg?
        redirect_to '/profile'
      elsif user.admin?
        redirect_to '/admin/dashboard'
      elsif user.merch_employee? || user.merch_admin?
        redirect_to '/merchant/dashboard'
      end
    else
      flash.now[:error] = "Email and password do not match."
      render :new
    end
  end

  private
    def login_params
      params.permit(:email, :password)
    end

    def redirect_user
      if current_user.reg?
        redirect_to '/profile'
      elsif current_merchant?
        redirect_to '/merchant/dashboard'
      elsif current_admin?
        redirect_to '/admin/dashboard'
      end
    end
end
