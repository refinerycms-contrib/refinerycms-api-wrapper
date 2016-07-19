require "refinery/api/helpers/client_helper"

module Refinery
  module API
    module Blog
      class Posts
        include Refinery::API::Helpers::ClientHelper

        def index
          config.connection.get(posts_path)
        end

        def show(id:)
          config.connection.get(posts_path(id))
        end

        def create(post:)
          config.connection.post(posts_path) do |req|
            req.body = post.to_json
          end
        end

        def update(id:, post:)
          config.connection.put(posts_path(id)) do |req|
            req.body = post.to_json
          end
        end

        def destroy(id:)
          config.connection.delete(posts_path(id))
        end

        private
          def posts_path(id = nil)
            path = api_path + "/blog/posts"
            path << "/#{id}" if id
            path
          end
      end
    end
  end
end
