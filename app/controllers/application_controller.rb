class ApplicationController < ActionController::Base
  private
  
  include SessionsHelper

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
