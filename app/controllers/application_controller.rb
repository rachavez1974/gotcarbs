class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def heroku
    render html: "Kanishua, from Heroku Bitches!"
  end
end
