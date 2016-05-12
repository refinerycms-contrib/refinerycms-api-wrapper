require 'spec_helper'

module Refinery
  RSpec.describe API do
    it 'has a version number' do
      expect(API::VERSION).not_to be nil
    end

    it "proxies configuration to the block" do
      expect{ |probe| API.configure(&probe) }.to yield_control
    end

    it "sets configuration options through the block" do
      Refinery::API.configure do |config|
        config.api_token = "1234"
        config.api_url = "api.test.com"
      end

      expect(Refinery::API.configuration.api_token).to eq("1234")
      expect(Refinery::API.configuration.api_url).to eq("api.test.com")
    end
  end
end
