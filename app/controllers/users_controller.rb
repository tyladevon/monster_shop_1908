class UsersController < ApplicationController
  def new
  end

  def create
    user = User.create(user_params)
    if user.save
      flash[:success] = "You are now registered and logged in!"
      session[:user_id] = user.id
      redirect_to '/profile'
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to '/register'
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  private

  def user_params
    params.permit(:name, :street_address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
