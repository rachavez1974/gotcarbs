class CartsController < ApplicationController
  
  def show

    if @cart = current_user.carts.first
       @order = Order.new
     else
      redirect_to menu_path
     end
     @cart = current_user.carts.first
    @cart.destroy
    binding.pry
    redirect_to menu_path
  end

  def destroy
    @cart = current_user.carts.first
    @cart.destroy
    redirect_to menu_path
  end
end
