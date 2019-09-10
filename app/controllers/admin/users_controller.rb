class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :admin?, only: [:index, :new, :create, :show]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)  
  end

  def create
    params[:user][:email] = "#{params[:first_name]}#{rand 0..10000000}@gotcarbs.org"
    params[:user][:password] = User.new_token
    @user = User.new(user_params(params[:user].keys))
    
    if @user.save
      redirect_to admin_user_url(@user)
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

    def admin?
      redirect_to(root_url) unless current_user.admin?
    end
end
