class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params(params[:user].keys))
      if @user.save
        redirect_to @user
      else
        render 'new'
      end
  end

  def show  
  end

  private
    def user_params(user)
      params.require(:user).permit(user)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
