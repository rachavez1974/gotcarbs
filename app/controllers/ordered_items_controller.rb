class OrderedItemsController < ApplicationController
  

  # def create
  #   if current_user.carts.first.nil?
  #     @cart = current_user.carts.create
  #     add_item_to_cart
  #   else
  #     @cart = current_user.carts.first 
  #     @ordered_item = OrderedItem.find_by(:item_id => params[:ordered_item][:item_id])
  #     if @cart.ordered_items.include?(@ordered_item)
  #       increment_item_in_cart
  #     else
  #       add_item_to_cart
  #     end
  #   end 
  # end

  def add_one
    @ordered_item = OrderedItem.find(params[:id])
    increment_item_in_order
  end

  def minus_one
    @ordered_item = OrderedItem.find(params[:id])
    decrement_item_in_order
  end

  def destroy
    @ordered_item = OrderedItem.find(params[:id]).destroy
    flash[:success] = "Item deleted!"
    redirect_to order_path(@ordered_item.order)
  end

  private

  def item_params(item)
    params.require(:ordered_item).permit(item)
  end

  def add_item_to_order
    @ordered_item = OrderedItem.new(item_params(params[:ordered_item].keys))
    @cart.ordered_items << @ordered_item
    @cart.save
    redirect_to menu_path
  end

  def increment_item_in_order
    @ordered_item.quantity += 1
    @ordered_item.save
    redirect_to order_path(@ordered_item.order)
  end

  def decrement_item_in_order
    @ordered_item.quantity -= 1
    @ordered_item.save
    redirect_to order_path(@ordered_item.order)
  end

end
