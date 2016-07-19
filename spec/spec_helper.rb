$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'refinery/api'
require 'vcr'
require 'pry'
require 'dotenv'
Dotenv.load

require 'rack/test'

require "support/request_helpers"
require "support/fixture_helpers"

ENV['REFINERYCMS_API_TOKEN'] ||= '123'
ENV['REFINERYCMS_API_URL'] ||= 'http://localhost:3000'
ENV['REFINERYCMS_API_PATH'] ||= '/api/v1'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr_cassettes'
  c.hook_into :webmock

  c.filter_sensitive_data("REFINERYCMS_API_TOKEN") { ENV["REFINERYCMS_API_TOKEN"] }
  c.filter_sensitive_data("REFINERYCMS_API_URL") { ENV["REFINERYCMS_API_URL"] }
  c.filter_sensitive_data("REFINERYCMS_API_PATH") { ENV["REFINERYCMS_API_PATH"] }
end

RSpec.configure do |config|
  config.include Requests::JsonHelper
  config.include Fixtures::Helper

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    Refinery::API.configure do |conf|
      conf.api_token = ENV["REFINERYCMS_API_TOKEN"]
      conf.api_url = ENV["REFINERYCMS_API_URL"]
      conf.api_path = ENV["REFINERYCMS_API_PATH"]
    end
  end
end
