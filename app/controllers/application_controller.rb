class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def heroku
    render html: "Kanishua, from Heroku Bitches!"
  end

  #gets attribute keys from params hash for user
  def user_keys
    all_keys = params[:user].keys
    all_keys.collect do |key|
      next if key == "addresses_attributes"
      key
    end
  end

  #gets attribute keys from params hash for address
  def address_keys
    address_attr = params[:user]["addresses_attributes"].values
    address_attr[0].keys
  end
end
