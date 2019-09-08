class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user, except: [:new]



  def new
    if !logged_in? #or if looged in and admin
      @user = User.new
    else
      redirect_to root_url
    end
  end

  def create
    @user = User.new(user_params(params[:user].keys))
      if @user.save
        log_in @user
        flash[:success] = "Your profile has been created!" 
        redirect_to @user
      else
        render 'new'
      end
  end

  def show  
  end

  def update
    if @user.update_attributes(user_params(params[:user].keys))
      flash[:success] = "Your profile has been update!" 
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "The account for #{@user.first_name} has been deleted!"
    redirect_to root_url
  end

  private
    def user_params(user)
      params.require(:user).permit(user)
    end

    def set_user
      @user = User.find(params[:id])
    end

    # Before filters
    # Confirms a logged-in user.
    def logged_in_user
      #binding.pry
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      redirect_to(root_url) unless @user == current_user?(user) #or current_user? is admin
    end
end
