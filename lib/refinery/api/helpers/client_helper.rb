module Refinery
  module API
    module Helpers
      module ClientHelper
        def config
          @_config ||= Refinery::API.configuration
        end

        def api_path
          Refinery::API.configuration.api_path
        end
      end
    end
  end
end
