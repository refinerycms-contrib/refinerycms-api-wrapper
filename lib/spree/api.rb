require "spree/api/version"
require "spree/api/configuration"
require "spree/api/products"

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
