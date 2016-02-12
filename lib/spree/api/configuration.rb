require "faraday"

module Spree
  module API
    class Configuration
      attr_accessor :api_token, :api_url, :api_path

      def initialize
        @api_token = ""
        @api_url = ""
        @api_path = "/api"
      end

      def connection
        @_connection ||= ::Faraday.new(url: api_url,
          headers: { "X-Spree-Token" => api_token,
            "Content-Type" => "application/json" }) do |faraday|
              faraday.request :url_encoded
              faraday.adapter Faraday.default_adapter
        end
      end
    end
  end
end
