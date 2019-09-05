module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

#Excerpt From: Michael Hartl. “Ruby on Rails Tutorial.” Apple Books. 
end
