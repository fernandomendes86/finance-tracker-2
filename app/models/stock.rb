class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    begin
      twelve_data = TwelveDataService::TwelveDataReader.search_data(ticker_symbol)
      raise if twelve_data.code

      new(ticker: twelve_data.symbol, name: twelve_data.name, last_price: twelve_data.close)
    rescue => exception
      new.errors.add(:ticker, :blank, message: "#{ticker_symbol} was not found!")
    end
  end
end
