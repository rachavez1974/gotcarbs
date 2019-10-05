class SessionsController < ApplicationController

  def new
    if logged_in? && current_user.admin?
      redirect_to admin_root_path
    elsif logged_in? && !current_user.admin?
      redirect_to menu_path
    end
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
    redirect_to login_path   
  end

  private
    def make_user_from_oauth
      #if this is the first time creating user, sign them in, and make sure rest of info is entered
      #else redirect to current menu
      oauth_hash = request.env["omniauth.auth"]["info"]
      @user = User.find_by(email: oauth_hash["email"])
      if !@user
        @user = User.create_from_oauth(oauth_hash)
        get_user_info
      else
        if @user.addresses.any?{ |address| address.attributes.values.any? { |attr| attr == nil } }
          get_user_info
        else
          flash[:success] = "Welcome back #{@user.first_name}!"
          log_in(@user)
          redirect_to root_url
        end
      end
    end

    def get_user_info
      flash[:alert] = "Please fill out rest of information before placing order!" 
      log_in(@user)
      redirect_to edit_user_url(@user) 
    end

    def regular_sign_in
      # sign in user at website
      @user = User.find_by(email: params[:session][:email].downcase)
      
      if @user && @user.authenticate(params[:session][:password])
        log_in(@user)
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        if @user.admin?
          redirect_to admin_root_path 
        else
          redirect_back_or menu_path
        end
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
end
