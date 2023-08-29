class StocksController < ApplicationController
  def search
    @stock = Stock.new_lookup(params[:stock])
    @tracked_stocks = current_user.stocks
    if @stock.try(:full_message)
      flash.now[:alert] = @stock.full_message
    end    
    render 'users/my_portfolio'
  end
end
