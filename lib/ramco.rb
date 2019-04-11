require 'ramco/version'
require 'ramco/connection'
require 'ramco/errors'
require 'ramco/api/clear_cache'
require 'ramco/api/entities'
require 'ramco/api/entity_metadata'
require 'ramco/api/entity_types'
require 'ramco/api/entity'
require 'ramco/api/option_set'
require 'ramco/api/validate_user'

class Ramco
  attr_reader :connection
  
  include Ramco::API::ClearCache
  include Ramco::API::Entities
  include Ramco::API::EntityMetadata
  include Ramco::API::EntityTypes
  include Ramco::API::Entity
  include Ramco::API::OptionSet
  include Ramco::API::ValidateUser
  

  def initialize(options = {}, &block)
    @options = options
    @block = block if block
    return @connection = Ramco::Connection.new(options, &block) 
  end
  
  def self.api_key(api_key, api_url = nil)
    options = {:api_key => api_key}
    options[:api_url] = api_url if api_url
    Ramco.new  options
  end
    
  private
  
  def request(connection, params)
    connection.post do |req|
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = params.merge({"key" => connection.api_key})
    end.body["Data"]
  end
end
