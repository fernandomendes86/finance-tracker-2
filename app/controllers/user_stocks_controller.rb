class UserStocksController < ApplicationController
  before_action :set_stock_by_ticker, only: [:create]
  before_action :set_stock_by_id, only: [:destroy]

  def create 
    unless @stock
      @stock = Stock.new_lookup(params[:ticker])
      @stock.save
    end
    @user_stocks = UserStock.create(user: current_user, stock: @stock)
    flash[:notice] = "Stock #{@stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    user_stock = UserStock.find_by(user_id: current_user, stock_id: @stock)
    if user_stock
      user_stock.destroy
      flash[:notice] = "#{@stock.ticker} was successfully removed from portfolio"
      redirect_to my_portfolio_path
    end
  end

  private
  
  def set_stock_by_ticker
    @stock = Stock.find_by_ticker(params[:ticker])
  end

  def set_stock_by_id
    @stock = Stock.find(params[:id])
  end
end
