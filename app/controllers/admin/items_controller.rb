class Admin::ItemsController < ApplicationController
  layout "admin"
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user && :admin?, only: [:edit, :update, :show, :destroy]
    
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params(params[:item].keys))

    if @item.save
      flash[:success] = "Item created!"
      redirect_to @item
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    if @item.update_attributes(item_params(params[:item].keys))
      flash[:success] = "Item has been updated!" 
      redirect_to admin_item_path(@item)
    else
      render 'edit'
    end
  end

  def index
    if params[:menu]
      @items = Item.paginate(page: params[:page], per_page: 10).menu_items(params[:menu])
    else
      @items = Item.paginate(page: params[:page], per_page: 15)      
    end 
  end  

  def show
  end

  def search
    if params[:search_key]
      if @item = Item.find_by_id_or_name(params[:search_key])
        render 'show'
      else
        flash.now[:alert] = "Item not found, please try agagin!" 
        render 'search_item'
      end
    end
  end

  def destroy
    @item.destroy
    flash[:success] = "#{@item.name} has been deleted!"
    redirect_to admin_items_path
  end

  private
    def item_params(item)
      params.require(:item).permit(item)
    end
    def set_item
      @item = Item.find(params[:id])
    end
end
