class UserStocksController < ApplicationController
  before_action :set_stock_by_ticker, only: [:create]
  before_action :set_stock_by_id, only: [:destroy]

  def create 
    unless @stock
      @stock = Stock.new_lookup(params[:ticker])
      @stock.save
    end
    user_stocks = UserStock.create(user: current_user, stock: @stock)
    if user_stocks.persisted?
      flash[:notice] = "Stock #{@stock.name} was successfully added to your portfolio."
    else
      flash[:alert] =  "Stock #{@stock.name} was not added to your portfolio."
    end

    unless params[:user_friend].nil?
      redirect_to user_path(params[:user_friend])
    else
      redirect_to my_portfolio_path
    end  
  end

  def destroy
    user_stock = UserStock.find_by(user_id: current_user, stock_id: @stock)
    if user_stock.try(:destroy)
      flash[:notice] = "#{@stock.ticker} was not removed from the portfolio."
    else

    end

    redirect_to my_portfolio_path
  end

  private
  
  def set_stock_by_ticker
    @stock = Stock.find_by_ticker(params[:ticker])
  end

  def set_stock_by_id
    @stock = Stock.find(params[:id])
  end
end
