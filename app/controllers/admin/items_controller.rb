class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user && :admin?, only: [:edit, :update, :show, :destroy]
  
  def index
    if params[:menu]
      @items = Item.paginate(page: params[:page], per_page: 10).menu_items(params[:menu])
    else
      @items = Item.paginate(page: params[:page], per_page: 15)      
    end 
  end  

  def show
    if params[:key_search]
      @item = Item.item_menu(params[:key_search])
    else
      @item
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end
end
