module UserStocksHelper
  def blocking_message_to_stock(stock)
    return "10 stocks" unless current_user.under_stock_limit?
    return "this stock" if current_user.stock_already_tracked?(stock.ticker)
  end
end
