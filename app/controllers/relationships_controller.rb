class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:format])
    if current_user.follow(@user)
      flash[:notice] = "You are now following " + @user.email
      redirect_to users_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    flash[:alert] = "You are no longer following " + @user.email
    redirect_to users_path
  end

end
