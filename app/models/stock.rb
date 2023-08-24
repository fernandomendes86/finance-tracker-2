class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    begin
      #iex_client = IexService::IexReader.call
      #new(ticker: ticker_symbol, name: iex_client.company(ticker_symbol).company_name, last_price: iex_client.price(ticker_symbol))
      market_data = MarketDataService::MarketData.call_quotes(ticker_symbol)
      new(ticker: ticker_symbol, name: market_data.symbol.last, last_price: market_data.last.last)
    rescue => exception
      new.errors.add(:ticker, :blank, message:'Ticker symbol not found!')
    end
  end
end
