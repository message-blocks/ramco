require 'json/ext'
require 'multi_json'

class Ramco
  # Custom error class for rescuing from all Ramco errors
  class Error < StandardError
    def initialize(response=nil)
      @response = response
      super(build_error_message)
    end

    def response_body
      @response_body ||= if (body = @response[:body]) && !body.empty?
        if false and body.is_a?(String)
          MultiJson.load(body, :symbolize_keys => true)
        else
          body
        end
      else
        nil
      end
    end

    private

    def build_error_message
      return nil if @response.nil?

      message = if response_body
        "#{response_body["ResponseCode"]}: #{response_body["ResponseText"]}"
      else
        ''
      end

      "#{message}"
    end
  end

  # Raised when Ramco returns a 400 HTTP status code
  class BadRequest < Error; end

  # Raised when Ramco returns a 401 HTTP status code
  class Unauthorized < Error; end

  # Raised when Ramco returns a 404 HTTP status code
  class NotFound < Error; end

  # Raised when Ramco returns a 422 HTTP status code
  class InvalidUser < Error; end

  # Raised when Ramco returns a 500 HTTP status code
  class InternalServerError < Error; end

  # Raised when Ramco returns a 502 HTTP status code
  class BadGateway < Error; end

  # Raised when Ramco returns a 503 HTTP status code
  class ServiceUnavailable < Error; end
end

module Faraday
  class Response::RaiseRamcoError < Response::Middleware
    ERROR_MAP = {
      400 => Ramco::BadRequest,
      401 => Ramco::Unauthorized,
      422 => Ramco::InvalidUser,
      500 => Ramco::InternalServerError,
      502 => Ramco::BadGateway,
      503 => Ramco::ServiceUnavailable
    }

    def on_complete(response)
      key = response.body["ResponseCode"].to_i
      raise ERROR_MAP[key].new(response) if ERROR_MAP.has_key? key
    end
  end
end
