class UsersController < ApplicationController
  before_action :my_friends, only: [:search]

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    if params[:friend].present?
      @friends_result = User.search(params[:friend], current_user)
      flash.now[:alert] = "Couldn't find user." unless @friends_result.present?

      render 'users/my_friends'
    else
      flash.now[:alert] = "Please enter your name or email to search."

      render 'users/my_friends'
    end
  end
end
