class Admin::AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user && :admin?, only: [:edit, :update, :show, :destroy]

  def new
    if params[:user_id] && !User.exists?(params[:user_id])
      flash[:alert] = "User not found."
      redirect_to admin_users_url
    else
      @address = Address.new(user_id: params[:user_id])
    end
  end
     
  def create
    @address = Address.new(address_params(params[:address].keys))
    if @address.save
      flash[:success] = "Address created!"
      redirect_to admin_user_url(find_user(params[:user_id]))
    else
      render 'new'
    end
  end

  def show
  end

  def index
    if params[:user_id]
      @addresses = Address.user_addresses(params[:user_id])
    else
      flash[:alert] = "No addresses for this users, please add one!"
    end
  end

  def edit
    if params[:user_id]  
      if find_user(params[:user_id]).nil?
        flash[:alert] = "Author not found."
        redirect_to admin_users_path
      else
        redirect_to admin_users_path(@user), flash[:alert] = "Address not found." if @address.nil?
      end
    else
      @address
    end
  end

  def update
    if @address.update_attributes(address_params(params[:address].keys))
      flash[:success] = "Address has been updated!" 
      redirect_to admin_user_url(find_user(params[:user_id]))
    else
      render 'edit'
    end
  end

  def destroy
    if params[:user_id]
      if find_user(params[:user_id]).nil?
        flash[:alert] = "User not found."
        redirect_to admin_users_url
      elsif @address.nil?
        flash[:alert] = "Address not found."
        redirect_to admin_users_path(@user)
      else
        @address.destroy
        flash[:success] = "The #{@address.address_type} for #{@address.user.full_name} has been deleted!"
        redirect_to admin_user_url(@address.user)
      end
    else
      @address
    end
  end

  private
    def address_params(address)
      params.require(:address).permit(address)
    end

    def set_address
      @address = Address.find(params[:id])
    end

    def find_user(user_id)
      @user = User.find_by(id: user_id)
    end
end
