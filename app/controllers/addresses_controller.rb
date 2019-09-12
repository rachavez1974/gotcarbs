class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user && :correct_address_user, only: [:edit, :update, :show, :destroy]

  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.build(address_params(params[:address].keys))
    if @address.save
      flash[:success] = "Address created!"
      redirect_to user_url(current_user)
    else
      render 'new'
    end
  end

  def show
    
  end

  def index
    @addresses = current_user.addresses
  end

  def edit
  end

  def update
    if @address.update_attributes(address_params(params[:address].keys))
      flash[:success] = "Address has been updated!" 
      redirect_to user_url(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @address.destroy
    flash[:success] = "The #{@address.address_type} for #{@current_user.first_name} has been deleted!"
    redirect_to user_url(current_user)
  end

  private
    def address_params(address)
      params.require(:address).permit(address)
    end

    def set_address
      @address = Address.find(params[:id])
    end

    # Confirms the correct user.
    def correct_address_user
      redirect_to(root_url) unless current_user?(@address.user)
    end
end
