class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      login(user_params[:email], user_params[:password])
      redirect_to controller: 'tasks', action: 'index'
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
