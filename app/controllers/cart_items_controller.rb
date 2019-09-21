class CartItemsController < ApplicationController

  def create
    if current_user.carts.first.nil?
      @cart = current_user.carts.create
      add_item_to_cart
    else
      @cart = current_user.carts.first 
      @cart_item = CartItem.find_by(:item_id => params[:cart_item][:item_id])
      if @cart.cart_items.include?(@cart_item)
        increment_item_in_cart
      else
        add_item_to_cart
      end
    end 
  end

  def add_one
    increment_item_in_cart(params)
  end

  def minus_one
    decrement_item_in_cart(params)
  end

  def destroy
    CartItem.find(params[:id]).destroy
    flash[:success] = "Item deleted!"
    redirect_to cart_path(current_user.carts.first)
  end

  private

  def item_params(item)
    params.require(:cart_item).permit(item)
  end

  def add_item_to_cart
    @cart_item = CartItem.new(item_params(params[:cart_item].keys))
    @cart.cart_items << @cart_item
    @cart.save
    redirect_to menu_path
  end

  def increment_item_in_cart(params)
    @cart_item = CartItem.find_by(:item_id => params[:id])
    @cart_item.quantity += 1
    @cart_item.save
    redirect_to cart_path(current_user.carts.first)
  end

  def decrement_item_in_cart(params)
    @cart_item = CartItem.find_by(:item_id => params[:id])
    @cart_item.quantity -= 1
    @cart_item.save
    redirect_to cart_path(current_user.carts.first)
  end

end
