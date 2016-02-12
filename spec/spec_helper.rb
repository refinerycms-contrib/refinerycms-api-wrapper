$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'spree/api'
require 'vcr'
require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr_cassettes'
  c.hook_into :webmock
end
