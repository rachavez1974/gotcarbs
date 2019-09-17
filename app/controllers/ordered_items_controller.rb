class OrderedItemsController < ApplicationController
  

  def create
    @order = current_order
    @order.user_id = current_user.id
    @order.ordered_items.new(item_params(params[:ordered_item].keys))
    @order.save

    session[:order_id] = @order.id
    redirect_to menu_path
  end

  private

  def item_params(item)
    params.require(:ordered_item).permit(item)
  end
end
