class Admin::ItemsController < ApplicationController
  before_action :set_address, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user && :admin?, only: [:edit, :update, :show, :destroy]
  
  def index
    @items = Item.all    
  end  
end
