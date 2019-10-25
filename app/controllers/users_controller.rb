class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "You are now registered and logged in!"
      session[:user_id] = @user.id
      redirect_to '/profile'
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    if current_user
      @user = current_user
    else
      render file: "/public/404"
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params) && params[:commit] == "Update Information"
      flash[:success] = "Your information has been updated!"
      redirect_to '/profile'
    elsif params[:commit] == "Submit" && params[:password] == params[:password_confirmation]
      @user.password = params[:password]
      @user.save!
      flash[:success] = "Your password has been updated!"
      redirect_to '/profile'
    elsif params[:commit] == "Update Information"
      flash[:notice] = @user.errors.full_messages.to_sentence
      redirect_to '/profile/edit/profile'
    else 
      flash[:notice] = @user.errors.full_messages.to_sentence
      redirect_to '/profile/edit/password'
    end
  end

  private

  def user_params
    params.permit(:name, :street_address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
