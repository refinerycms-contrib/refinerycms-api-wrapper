require "refinery/api/helpers/client_helper"

module Refinery
  module API
    module Inquiries
      class Inquiries
        include Refinery::API::Helpers::ClientHelper

        def index
          config.connection.get(inquiries_path)
        end

        def show(id:)
          config.connection.get(inquiries_path(id))
        end

        def create(inquiry:)
          config.connection.post(inquiries_path) do |req|
            req.body = inquiry.to_json
          end
        end

        def destroy(id:)
          config.connection.delete(inquiries_path(id))
        end

        private
          def inquiries_path(id = nil)
            path = api_path + "/inquiries/inquiries"
            path << "/#{id}" if id
            path
          end
      end
    end
  end
end
