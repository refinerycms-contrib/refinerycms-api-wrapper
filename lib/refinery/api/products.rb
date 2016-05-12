require "refinery/api/helpers/client_helper"

module Refinery
  module API
    class Products
      include Refinery::API::Helpers::ClientHelper

      def index
        config.connection.get(products_path)
      end

      def product_attributes
        @_attributes ||= config.connection.get(products_path + "/new")
      end

      def create(product:)
        config.connection.post(products_path) do |req|
          req.body = product.to_json
        end
      end

      def show(id:)
        config.connection.get(products_path(id))
      end

      def update(id:, product:)
        config.connection.put(products_path(id)) do |req|
          req.body = product.to_json
        end
      end

      def delete(id:)
        config.connection.delete(products_path(id))
      end

      private
        def products_path(id = nil)
          path = api_path + "/products"
          path << "/#{id}" if id
          path
        end
    end
  end
end
