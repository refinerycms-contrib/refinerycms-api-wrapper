require "spec_helper"

module Refinery
  module API
    RSpec.describe Configuration do
      let(:config) { described_class.new }

      it "has default values" do
        expect(config.api_url).to eq("")
        expect(config.api_token).to eq("")
      end

      it "sets values for token and url" do
        config.api_token = "1234"
        config.api_url = "http://api.example.com"

        expect(config.api_token).to eq("1234")
        expect(config.api_url).to eq("http://api.example.com")
      end

      describe "#connection" do
        before do
          config.api_token = "1234"
          config.api_url = "http://api.example.com"
        end

        it "spawns a faraday connection instance" do
          expect(config.connection).to be_a(Faraday::Connection)
        end
      end
    end
  end
end
