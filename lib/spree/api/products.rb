require "faraday"

module Spree
  module API
    class Products
      def index
        config.connection.get("/shop/api/products")
      end

      def product_attributes
        @_attributes ||= config.connection.get("/shop/api/products/new")
      end

      def create(product:)
        config.connection.post("/shop/api/products") do |req|
          req.headers["Content-Type"] = "application/json"
          req.body = product.to_json
        end
      end

      def show(id:)
        config.connection.get(api_path + "/products/#{id}")
      end

      def update(id:, product:)
        config.connection.put(api_path + "/products/#{id}") do |req|
          req.headers["Content-Type"] = "application/json"
          req.body = product.to_json
        end
      end

      def delete(id:)
        config.connection.delete(api_path + "/products/#{id}")
      end

      private
        def config
          @_config ||= Spree::API.configuration
        end

        def api_path
          "/shop/api/"
        end
    end
  end
end
