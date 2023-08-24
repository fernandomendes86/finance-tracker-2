class MarketDataService::MarketData
  attr_reader :market_data

  def initialize(ticker_symbol)
    @market_data = market_data_quotes(ticker_symbol)
  end

  def self.call_quotes(ticker_symbol)
    new(ticker_symbol).market_data
  end

  private
    def market_data_quotes(ticker_symbol)
      quotes_body = Faraday.get("https://api.marketdata.app/v1/stocks/quotes/#{ticker_symbol}/").body
      JSON.parse(quotes_body, object_class: OpenStruct)
    end
end