class Admin::DashboardController < ApplicationController
  layout "admin"
  before_action :admin?

  def home 
  end

  def support
  end
end
