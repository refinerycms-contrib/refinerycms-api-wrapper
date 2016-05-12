require "refinery/api/helpers/client_helper"

module Refinery
  module API
    class Pages
      include Refinery::API::Helpers::ClientHelper

      def index
        config.connection.get(pages_path)
      end

      def show(id:)
        config.connection.get(pages_path(id))
      end

      private
        def pages_path(id = nil)
          path = api_path + "/pages"
          path << "/#{id}" if id
          path
        end
    end
  end
end
