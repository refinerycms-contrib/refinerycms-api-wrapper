module Spree
  module API
    class OptionValues
      include Spree::API::Helpers::ClientHelper

      def create(option_type_id:, option_value:)
        config.connection.post(
          option_values_path(option_type_id: option_type_id)) do |req|
            req.body = option_value.to_json
          end
      end

      def destroy(option_type_id:, id:)
        config.connection.delete(
          option_values_path(option_type_id: option_type_id, id: id))
      end

      def update(option_type_id:, id:, option_value:)
        config.connection.put(
          option_values_path(option_type_id: option_type_id, id: id)) do |req|
            req.body = option_value.to_json
          end
      end

      private
      def option_values_path(option_type_id:, id: nil)
        path = api_path + "/option_types/#{option_type_id}/option_values"
        path << "/#{id}" if id
        path
      end
    end
  end
end
