class MenusController < ApplicationController
  def show
    if params[:menu]
      @items = Item.menu(params[:menu])
    else
      @items = Item.current_menu_only
    end
    # binding.pry
    @order_item = OrderedItem.new
  end
end

