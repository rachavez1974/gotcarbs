class OrdersController < ApplicationController
  before_action :set_order, only: [:show]
  before_action :logged_in_user, only: [:show, :index]

  def show
  end

  def index
    @orders = current_user.orders.paginate(page: params[:page], per_page: 5)
  end

  def create
    @order = current_user.orders.new
    @cart = current_user.carts.first
    current_user.carts.first.cart_items.each do |cart_item|
      @order.ordered_items.new(order_items_hash(cart_item))
    end
    @order.save
    current_user.carts.first.destroy
    redirect_to @order
  end

  private  
    def set_order
      @order = Order.find(params[:id])
      unless current_user.id == @order.user_id
        flash[:alert] = "Only owners can see their orders."
        redirect_to menu_path
      end
    end 

    def order_items_hash(item)
      {:quantity => item.quantity, :item_id => item.item_id}
    end

end
