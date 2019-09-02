class ApplicationController < ActionController::Base
  def heroku
    render html: "Kanishua, from Heroku Bitches!"
  end
end
