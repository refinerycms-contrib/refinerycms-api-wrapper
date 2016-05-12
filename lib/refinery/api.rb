require "refinery/api/version"
require "refinery/api/configuration"
require "refinery/api/pages"
require "refinery/api/products"
require "refinery/api/variants"
require "refinery/api/taxonomies"
require "refinery/api/taxons"
require "refinery/api/option_types"
require "refinery/api/option_values"

require "faraday"

module Refinery
  module API
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
