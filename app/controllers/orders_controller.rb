class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :show, :destroy]
  
  def index
    @orders = Order.all
  end

  def show
  
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params(params[:order].keys))
    current_cart.ordered_items.each do |item|
      @order.ordered_items << item
      item.cart_id = nil
    end
    @order.save
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    redirect_to menu_path
  send

  private
    def order_params(order)
      params.require(:order).permit(order)
    end
  
    def set_order
      @order = Order.find(params[:id])
    end 
end
