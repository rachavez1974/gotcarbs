class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user && :admin?, only: [:edit, :update, :show, :destroy]
  
  def index
    if params[:id]
      @orders = Order.paginate(page: params[:page], per_page: 5).user_orders(params[:id])
      
      if !@orders.empty?
        @user = User.find(params[:id])
      else
        flash[:alert] = "User not found, please try again."
        render 'index'
      end
    else
      @orders = Order.paginate(page: params[:page], per_page: 15)      
    end 
  end

  def show
  end

  def create
    @order = current_user.orders.new
    @cart = current_user.carts.first
    current_user.carts.first.cart_items.each do |cart_item|
      @order.ordered_items.new(order_items_hash(cart_item))
    end
    @order.save
    current_user.carts.first.destroy
    redirect_to menu_path
  end

  def destroy
    @order.destroy
    flash[:success] = "Order number #{@order.id} has been deleted!"
    redirect_to root_url
  end

  private  
    def set_order
      @order = Order.find(params[:id])
    end 

    def order_items_hash(item)
      {:quantity => item.quantity, :item_id => item.item_id}
    end
end
