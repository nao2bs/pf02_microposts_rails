class UsersController < ApplicationController
  before_action :auth_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end  
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Success Update"
      redirect_to edit_user_path(@user)
    else  
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.following_users
  end
  
  def followers #フォローされているユーザー
    @user = User.find(params[:id])
    @followers = @user.follower_users
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location)
  end
  
  def auth_user
    @user = User.find(params[:id])
    redirect_to root_url unless @user == current_user
  end  
  
end