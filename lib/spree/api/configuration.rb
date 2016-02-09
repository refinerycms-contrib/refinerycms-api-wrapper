module Spree
  module API
    class Configuration
      attr_accessor :api_token, :api_url

      def initialize
        @api_token = ""
        @api_url = ""
      end
    end
  end
end
