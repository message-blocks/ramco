require 'faraday'
require 'faraday_middleware'
require 'multi_json'

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
        builder.use     Faraday::Response::RaiseRamcoError
        builder.use     FaradayMiddleware::EncodeJson
        builder.use     FaradayMiddleware::ParseJson
        builder.adapter :typhoeus
      end
    end
  end
end