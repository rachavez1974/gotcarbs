class Admin::AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user && :admin?, only: [:edit, :update, :show, :destroy]

  def new
    if params[:user_id] && !User.exists?(params[:user_id])
      redirect_to admin_users_url, flash[:alert] = "User not found."
    else
      @address = Address.new(user_id: params[:user_id])
    end
  end
     
  def create
    @address = Address.new(address_params(params[:address].keys, params[:user_id]))
    if @address.save
      flash[:success] = "Address created!"
      redirect_to admin_user_url(find_user(params[:user_id]))
    else
      render 'new'
    end
  end

  # def show

  # end

  def index
    if params[:user_id]
      @addresses = Address.user_addresses
    else
      flash[:success] = "No addresses for this users, please add one!"
    end
  end

  # def edit
  # end

  # def update
  #   if @address.update_attributes(address_params(params[:address].keys))
  #     flash[:success] = "Address has been updated!" 
  #     redirect_to user_url(current_user)
  #   else
  #     render 'edit'
  #   end
  # end

  # def destroy
  #   @address.destroy
  #   flash[:success] = "The #{@address.address_type} for #{@current_user.first_name} has been deleted!"
  #   redirect_to user_url(current_user)
  # end

  private
    def address_params(address, user_id)
      params.require(:address).permit(address, user_id)
    end

    def set_address
      @address = Address.find(params[:id])
    end

    def find_user(user_id)
      @user = User.find_by(id: user_id)
    end
end
