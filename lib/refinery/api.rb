require "refinery/api/version"
require "refinery/api/configuration"
require "refinery/api/pages"

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
