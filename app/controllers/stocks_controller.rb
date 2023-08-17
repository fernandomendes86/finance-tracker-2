class StocksController < ApplicationController
  def search
    @stock = Stock.new_lookup(params[:stock])
    @stock_errors = 'Ticker symbol not found!' unless @stock
    render 'users/my_portfolio'
  end
end
