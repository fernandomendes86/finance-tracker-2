class IexService::IexReader
  attr_reader :iex_client

  def initialize
    @iex_client = connect_iex_client
  end

  def self.call
    new.iex_client
  end

  private
    def connect_iex_client
      IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.iex.publishable,
        endpoint: 'https://cloud.iexapis.com/v1'
      )
    end
end