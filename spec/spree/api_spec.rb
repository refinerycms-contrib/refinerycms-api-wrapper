require 'spec_helper'

module Spree
  RSpec.describe API do
    it 'has a version number' do
      expect(API::VERSION).not_to be nil
    end

    it "proxies configuration to the block" do
      expect{ |probe| API.configure(&probe) }.to yield_control
    end
  end
end
