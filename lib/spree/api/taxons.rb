require "spree/api/helpers/client_helper"

module Spree
  module API
    class Taxons
      include Spree::API::Helpers::ClientHelper

      def index(taxonomy_id:)
        config.connection.get(taxons_path(taxonomy_id))
      end

      def show(taxonomy_id:, id:)
        config.connection.get(taxons_path(taxonomy_id, id))
      end

      def create(taxonomy_id:, taxon:)
        config.connection.post(taxons_path(taxonomy_id)) do |req|
          req.body = taxon.to_json
        end
      end

      def update(taxonomy_id:, id:, taxon:)
        config.connection.put(taxons_path(taxonomy_id, id)) do |req|
          req.body = taxon.to_json
        end
      end

      def destroy(taxonomy_id:, id:)
        config.connection.delete(taxons_path(taxonomy_id, id))
      end

      private
        def taxons_path(taxonomy_id, id = nil)
          path = api_path + "/taxonomies/#{taxonomy_id}/taxons"
          path << "/#{id}" if id
          path
        end
    end
  end
end
