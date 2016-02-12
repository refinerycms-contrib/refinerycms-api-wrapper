$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'spree/api'
require 'vcr'
require 'pry'

require "support/request_helpers"

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
  config.include Requests::JsonHelper

  config.before(:each) do
    Spree::API.configure do |conf|
      conf.api_token = "d3d1038e9338436c2db1e9ca597ef31b430e937aef90fba6"
      conf.api_url = "http://localhost:3000"
      conf.api_path = "/shop/api"
    end
  end
end
