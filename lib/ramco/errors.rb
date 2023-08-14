require 'json/ext'
require 'multi_json'
require 'faraday'

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

module FaradayMiddleware
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case JSON.parse(response.body)["ResponseCode"]
        when 400
          raise Ramco::BadRequest
        when 401
          raise Ramco::Unauthorized
        when 422
          raise Ramco::InvalidUser
        when 500
          raise Ramco::InternalServerError
        when 502
          raise Ramco::BadGateway
        when 503
          raise Ramco::ServiceUnavailable
        end
      end
    end
  end

  def initialize(app)
    super app
    @parser = nil
  end
end
