class FavoritesController < ApplicationController
  before_action :logged_in_user
  
  #
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(@micropost)
    flash[:success] = "add Favorite"
    redirect_to :back
  end
  
  
  
  def destroy
     @micropost = current_user..find(params[:id]).micropost
     current_user.delete_favorite(@micropost)
  end
  
  
end
