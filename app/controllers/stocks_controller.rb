class StocksController < ApplicationController
  def search
    @stock = Stock.new_lookup(params[:stock])
    @tracked_stocks = current_user.stocks
    
    render 'users/my_portfolio'
  end
end
