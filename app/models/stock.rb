class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    begin
      iex_client = IexService::IexReader.call
      new(ticker: ticker_symbol, name: iex_client.company(ticker_symbol).company_name, last_price: iex_client.price(ticker_symbol))
    rescue => exception
      new.errors.add(:ticker, :blank, message:'Ticker symbol not found!')
    end
  end
end
