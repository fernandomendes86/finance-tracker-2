class TwelveDataService::TwelveDataReader
  TWELVE_KEY = Rails.application.credentials.twelve.pkey
  attr_reader :twelve_data

  def initialize(ticker_symbol)
    @twelve_data = twelve_data_client(ticker_symbol)
  end

  def self.search_data(ticker_symbol)
    new(ticker_symbol).twelve_data
  end

  private
    def twelve_data_client(ticker_symbol)
      endpoint_quote = 'https://api.twelvedata.com/quote?'
      twelve_data_body = Faraday.get("#{endpoint_quote}symbol=#{ticker_symbol}&apikey=#{TWELVE_KEY}").body
      JSON.parse(twelve_data_body, object_class: OpenStruct)
    end
end