class OrderedItemsController < ApplicationController
  

  def create
    if current_user.carts.first.nil?
      @cart = current_user.carts.create
      add_item_to_cart
    else
      @cart = current_user.carts.first 
      @ordered_item = OrderedItem.find_by(:item_id => params[:ordered_item][:item_id])
      if @cart.ordered_items.include?(@ordered_item)
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
    OrderedItem.find(params[:id]).destroy
    flash[:success] = "Item deleted!"
    redirect_to cart_path(current_user.carts.first)
  end

  private

  def item_params(item)
    params.require(:ordered_item).permit(item)
  end

  def add_item_to_cart
    @ordered_item = OrderedItem.new(item_params(params[:ordered_item].keys))
    @cart.ordered_items << @ordered_item
    @cart.save
    redirect_to menu_path
  end

  def increment_item_in_cart(params)
    @ordered_item = OrderedItem.find_by(:item_id => params[:id])
    @ordered_item.quantity += 1
    @ordered_item.save
    redirect_to cart_path(current_user.carts.first)
  end

  def decrement_item_in_cart(params)
    @ordered_item = OrderedItem.find_by(:item_id => params[:id])
    @ordered_item.quantity -= 1
    @ordered_item.save
    redirect_to cart_path(current_user.carts.first)
  end

end
