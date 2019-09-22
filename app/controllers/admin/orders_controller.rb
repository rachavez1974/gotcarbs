class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user && :admin?, only: [:index, :show, :destroy]
  
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
