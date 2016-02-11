require "faraday"

module Spree
  module API
    class Configuration
      attr_accessor :api_token, :api_url

      def initialize
        @api_token = ""
        @api_url = ""
      end

      def connection
        @_connection ||= ::Faraday.new(url: api_url, headers: { "X-Spree-Token" => api_token }) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
      end
    end
  end
end
