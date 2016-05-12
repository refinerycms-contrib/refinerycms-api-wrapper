module Refinery
  module API
    class OptionTypes
      include Refinery::API::Helpers::ClientHelper

      def index
        config.connection.get(option_types_path)
      end

      def create(option_type:)
        config.connection.post(option_types_path) do |req|
          req.body = option_type.to_json
        end
      end

      def show(id:)
        config.connection.get(option_types_path(id))
      end

      def update(id:, option_type:)
        config.connection.put(option_types_path(id)) do |req|
          req.body = option_type.to_json
        end
      end

      def destroy(id:)
        config.connection.delete(option_types_path(id))
      end

      private
      def option_types_path(id = nil)
        path = api_path + "/option_types"
        path << "/#{id}" if id
        path
      end
    end
  end
end
