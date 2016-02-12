module Spree
  module API
    module Helpers
      module ClientHelper
        def config
          @_config ||= Spree::API.configuration
        end

        def api_path
          Spree::API.configuration.api_path
        end
      end
    end
  end
end
