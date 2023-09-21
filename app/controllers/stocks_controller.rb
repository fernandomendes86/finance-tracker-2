class StocksController < ApplicationController
  def search
    @stock = Stock.new_lookup(params[:stock])
    @tracked_stocks = current_user.stocks
    flash.now[:alert] = @stock.full_message if @stock.try(:full_message)
    
    render 'users/my_portfolio'
  end
end
