class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    iex_client = IexService::IexReader.call
    iex_client.price(ticker_symbol)
  end

end
