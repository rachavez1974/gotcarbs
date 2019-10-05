class CartsController < ApplicationController
  before_action :logged_in_user, only: [:show, :destroy]
  
  def show
    if @cart = current_user.carts.first
       @order = Order.new
     else
      flash[:alert] = "Your cart is empty, please make your selectiona."
      redirect_to menu_path
     end
  end

  def destroy
    @cart = current_user.carts.first
    @cart.destroy
    redirect_to menu_path
  end
end
