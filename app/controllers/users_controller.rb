class UsersController < ApplicationController
  before_action :my_friends, only: [:search]

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friend = User.search(params[:friend]).first
      flash.now[:alert] = "Couldn't find user!" unless @friend
      render 'users/my_friends'
    else
      flash.now[:alert] = "Please enter your name or email to search"
      render 'users/my_friends'
    end
  end
end
