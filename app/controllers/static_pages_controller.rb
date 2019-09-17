class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to menu_url
    else
      render 'home'
    end
  end

  def contact
  end

  def offers
  end

  def menus
  end

  def about
  end
end
