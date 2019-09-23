class OrdersController < ApplicationController
  before_action :set_order, only: [:show]
  before_action :logged_in_user, only: [:show]
  before_action :correct_user, only: [:show]

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
    end 

    def order_items_hash(item)
      {:quantity => item.quantity, :item_id => item.item_id}
    end

     # Confirms the correct user.
    def correct_user
      redirect_to(root_url) unless current_user?(@order.user)
    end

end
