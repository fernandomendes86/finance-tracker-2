class FriendshipsController < ApplicationController
  before_action :set_friend, only: [:create]

  def create
    friendship = current_user.friendships.build(friend: @friend)
    if friendship.save
      flash[:notice] = "Following user" 
    else
      flash[:alert] = "Unable to follow user"
    end

    redirect_to my_friends_path
  end

  def destroy
    friendship = current_user.friendships.find_by_friend_id(params[:id])
    if friendship
      friendship.destroy
      flash[:notice] = "You stopped following!"
      
      redirect_to my_friends_path
    end
  end

  private

  def set_friend
    @friend = User.find(params[:friend])
  end

end
