require "refinery/api/helpers/client_helper"

module Refinery
  module API
    class Images
      include Refinery::API::Helpers::ClientHelper

      def index
        config.connection.get(images_path)
      end

      def show(id:)
        config.connection.get(images_path(id))
      end

      def create(image:)
        config.connection.post(images_path, image)
      end

      def update(id:, image:)
        config.connection.put(images_path(id), image)
      end

      def destroy(id:)
        config.connection.delete(images_path(id))
      end

      private
        def images_path(id = nil)
          path = api_path + "/images"
          path << "/#{id}" if id
          path
        end
    end
  end
end
