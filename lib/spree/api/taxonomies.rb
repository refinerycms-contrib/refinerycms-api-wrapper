require "spree/api/helpers/client_helper"

module Spree
  module API
    class Taxonomies
      include Spree::API::Helpers::ClientHelper

      def index
        config.connection.get(taxonomies_path)
      end

      def show(id:)
        config.connection.get(taxonomies_path(id))
      end

      def create(taxonomy:)
        config.connection.post(taxonomies_path) do |req|
          req.body = taxonomy.to_json
        end
      end

      def update(taxonomy:, id:)
        config.connection.put(taxonomies_path(id)) do |req|
          req.body = taxonomy.to_json
        end
      end

      def destroy(id:)
        config.connection.delete(taxonomies_path(id))
      end

      private
        def taxonomies_path(id = nil)
          path = api_path + "/taxonomies"
          path << "/#{id}" if id
          path
        end
    end
  end
end
