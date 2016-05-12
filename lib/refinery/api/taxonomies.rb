require "refinery/api/helpers/client_helper"

module Refinery
  module API
    class Taxonomies
      include Refinery::API::Helpers::ClientHelper

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

      def taxon_create(taxonomy_id:, taxon:)
        config.connection.post(taxons_path(taxonomy_id)) do |req|
          req.body = taxon.to_json
        end
      end

      def taxon_list(taxonomy_id:)
        config.connection.get(taxons_path(taxonomy_id))
      end

      def taxon_update(taxonomy_id:, taxon_id:, taxon:)
        config.connection.put(taxons_path(taxonomy_id, taxon_id)) do |req|
          req.body = taxon.to_json
        end
      end

      def taxon_destroy(taxonomy_id:, taxon_id:)
        config.connection.delete(taxons_path(taxonomy_id, taxon_id))
      end

      private
        def taxonomies_path(id = nil)
          path = api_path + "/taxonomies"
          path << "/#{id}" if id
          path
        end

        def taxons_path(taxonomy_id, id = nil)
          path = api_path + "/taxonomies/#{taxonomy_id}/taxons"
          path << "/#{id}" if id
          path
        end
    end
  end
end
