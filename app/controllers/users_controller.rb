class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update, :show, :destroy]

  def new
    if !logged_in?
      @user = User.new
      @user.addresses.build
    else
      redirect_to root_url
    end
  end

  def create
    @user = User.new(user_params(user_keys, address_keys))
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
    if @user.update_attributes(user_params(user_keys, address_keys))
      flash[:success] = "Your profile has been updated!" 
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
    def user_params(user, address)
      params.require(:user).permit(user, addresses_attributes: address)
    end

    def set_user
      @user = User.find(params[:id])
    end

    # Before filters
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
end
