require 'multi_json'
require 'faraday'

class Ramco
  class Connection < Faraday::Connection
    attr_reader :hash, :api_key

    # Instantiates connection, accepts an options hash
    # for authenticated access
    #
    # Ramco expects
    #   :key => "API Key"

    def initialize(hash={})
      @hash = hash
      @api_key = hash[:api_key] if hash.has_key? :api_key

      super(hash[:api_url] || 'https://api.ramcoams.com/api/v2/') do |builder|
        yield builder if block_given?
        builder.use FaradayMiddleware::RaiseHttpException
      end
    end
  end
end
