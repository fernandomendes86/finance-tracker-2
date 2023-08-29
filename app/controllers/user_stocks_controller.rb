class UserStocksController < ApplicationController
  before_action :set_stock, only: [:create]

  def create 
    unless @stock
      @stock = Stock.new_lookup(params[:ticker])
      @stock.save
    end
    @user_stocks = UserStock.create(user: current_user, stock: @stock)
    flash[:notice] = "Stock #{@stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end

  private
  
  def set_stock
    @stock = Stock.find_by_ticker(params[:ticker])
  end
end
