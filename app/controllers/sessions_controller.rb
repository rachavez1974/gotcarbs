class SessionsController < ApplicationController
  def new
  end

  def create
    if !request.env["omniauth.auth"].nil?
      #if this is the first timecreating user, sign them in, and make sure rest of info is entered
      #else redirect to current menu
      oauth_hash = request.env["omniauth.auth"]["info"].nil?
      @user = User.find_by(email: oauth_hash["email"])
      if !@user
        @user = User.create_from_oauth(oauth_hash)
        if !@user.nil?
          flash[:alert] = "Please fill out rest of information before placing order!" 
          log_in(@user)
          redirect_to edit_user_url(@user) 
        else
          flash[:alert] = "Please make you sure are signed in!" 
          redirect_to root_url
        end
      else
        #if any attributes are nil on subsequent attemtps, redirect_to edit 
        if @user.attributes.values.any? { |attr| attr == nil }
          log_in(@user)
          flash[:alert] = "Please fill out rest of information before placing order!" 
          redirect_to edit_user_url(@user)
        else
          flash[:success] = "Welcome back #{@user.first_name}!"
          log_in(@user) 
          redirect_to @user
        end
      end
    else
      @user = User.find_by(email: params[:session][:email].downcase)

      if @user && @user.authenticate(params[:session][:password])
        log_in(@user)
        redirect_to @user
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
  end

  # Logs out the current user.
  def destroy
    log_out
    redirect_to root_url    
  end
end
