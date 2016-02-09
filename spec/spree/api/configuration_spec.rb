require "spec_helper"

module Spree
  module API
    RSpec.describe Configuration do
      let(:config) { described_class.new }

      it "has default values" do
        expect(config.api_url).to eq("")
        expect(config.api_token).to eq("")
      end

      it "sets values for token and url" do
        config.api_token = "1234"
        config.api_url = "api.example.com"

        expect(config.api_token).to eq("1234")
        expect(config.api_url).to eq("api.example.com")
      end
    end
  end
end
