class FriendshipsController < ApplicationController
  def create
  end

  def destroy
    friendship = current_user.friendships.find_by_friend_id(params[:id])
    if friendship
      friendship.destroy
      flash[:notice] = "You stopped following!"
      
      redirect_to my_friends_path
    end
  end

end
