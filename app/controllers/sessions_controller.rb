class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: login_params[:email])
    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      if user.reg?
        redirect_to '/profile'
      else
        redirect_to '/dashboard'
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
end
