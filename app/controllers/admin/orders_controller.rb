class Admin::OrdersController < ApplicationController
  layout "admin"
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

  def search
    if params[:id]
      @order = Order.find_by(:id => params[:id])
      if !@order
        flash.now[:alert] = "Order not found, please try agagin!" 
        render 'search_order'
      else
          render 'show'
      end
    elsif params[:start_date]
      @orders = Order.find_by_date(params[:start_date])
      if @orders.empty?
        flash.now[:alert] = "We didn't find orders for this date!" 
        render 'search_order'
      else
        flash.now[:alert] = "We found the following orders for this date!" 
        render 'index'
      end
    end
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
