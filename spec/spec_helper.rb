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
end
