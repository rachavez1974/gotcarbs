class Admin::ItemsController < ApplicationController
  before_action :set_address, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user && :admin?, only: [:edit, :update, :show, :destroy]
  
  def index
    if params[:menu]
      @items = Item.paginate(page: params[:page], per_page: 10).menu_item(params[:menu])
    else
      @items = Item.paginate(page: params[:page], per_page: 15)      
    end 
  end  
end
