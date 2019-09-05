class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def new
    @user = User.new
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
end
