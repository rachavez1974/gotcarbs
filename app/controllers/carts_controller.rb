class CartsController < ApplicationController
  def show
    @cart = current_user.carts.first
  end

  def destroy
    @cart = current_user.carts.first
    @cart.destroy
    redirect_to menu_path
  end
end
