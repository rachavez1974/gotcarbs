class OrderedItemsController < ApplicationController
  

  def show
    @cart  = current_user.cart
  end

  def create
    
    if current_user.carts.first.nil?
      @cart = current_user.carts.create
      add_item_to_cart
    else
      @cart = current_user.carts.first 
      @ordered_item = OrderedItem.find_by(:item_id => params[:ordered_item][:item_id])
      if @cart.ordered_items.include?(@ordered_item)
        @ordered_item.quantity += 1
        @ordered_item.save
        redirect_to menu_path
      else
        add_item_to_cart
      end
    end
    
  end

  def edit
    
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

end
