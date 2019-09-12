class AddressesController < ApplicationController
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

  def index
    @addresses = current_user.addresses
  end

  private
    def address_params(address)
      params.require(:address).permit(address)
    end
end
