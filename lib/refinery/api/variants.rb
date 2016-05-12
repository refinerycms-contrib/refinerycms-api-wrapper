require "refinery/api/helpers/client_helper"

module Refinery
  module API
    class Variants
      include Refinery::API::Helpers::ClientHelper

      def index(product_id: nil)
        if product_id
          config.connection.get(variants_path(product_id))
        else
          config.connection.get(api_path + "/variants")
        end
      end

      def show(product_id:, id:)
        config.connection
          .get(variants_path(product_id, id))
      end

      def new(product_id:)
        config.connection.get(variants_path(product_id) + "/new")
      end

      def create(product_id:, variant:)
        config.connection.post(variants_path(product_id)) do |req|
          req.body = variant.to_json
        end
      end

      def update(product_id:, variant:, id:)
        config.connection.put(variants_path(product_id, id)) do |req|
          req.body = variant.to_json
        end
      end

      def destroy(product_id:, id:)
        config.connection.delete(variants_path(product_id, id))
      end

      private
        def variants_path(product_id, id = nil)
          path = api_path + "/products/#{product_id}/variants"
          path << "/#{id}" if id
          path
        end
    end
  end
end
