require "spree/api/helpers/client_helper"

module Spree
  module API
    class Products
      include Spree::API::Helpers::ClientHelper

      def index
        config.connection.get(api_path + products_path)
      end

      def product_attributes
        @_attributes ||= config.connection.get(api_path + products_path + "/new")
      end

      def create(product:)
        config.connection.post(api_path + products_path) do |req|
          req.body = product.to_json
        end
      end

      def show(id:)
        config.connection.get(api_path + products_path(id))
      end

      def update(id:, product:)
        config.connection.put(api_path + products_path(id)) do |req|
          req.body = product.to_json
        end
      end

      def delete(id:)
        config.connection.delete(api_path + products_path(id))
      end

      private
        def products_path(id = nil)
          path = "/products"
          path << "/#{id}" if id
          path
        end
    end
  end
end
