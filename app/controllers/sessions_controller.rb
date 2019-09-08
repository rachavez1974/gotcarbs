class SessionsController < ApplicationController
  def new
  end

  def create
    if !request.env["omniauth.auth"].nil?
      make_user_from_oauth
    else
      regular_sign_in
    end
  end

  # Logs out the current user.
  def destroy
    log_out
    redirect_to root_url    
  end

  private
    def make_user_from_oauth
      #if this is the first timecreating user, sign them in, and make sure rest of info is entered
      #else redirect to current menu
      oauth_hash = request.env["omniauth.auth"]["info"]
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
        update_user_from_oauth
      end
    end

    def update_user_from_oauth
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

    def regular_sign_in
      # sign in user at website
      @user = User.find_by(email: params[:session][:email].downcase)

      if @user && @user.authenticate(params[:session][:password])
        log_in(@user)
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to @user
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end

end
