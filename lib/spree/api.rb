require "spree/api/version"
require "spree/api/configuration"
require "spree/api/products"
require "spree/api/variants"
require "spree/api/taxonomies"
require "spree/api/taxons"
require "spree/api/option_types"
require "spree/api/option_values"

require "faraday"

module Spree
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
