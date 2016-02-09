require "spec_helper"

module Spree
  module API
    RSpec.describe Products do
      before do
        Spree::API.configure do |conf|
          conf.api_token = "1234"
          conf.api_url = "api.example.com"
        end
      end

      describe "#index" do
        it "fetches a list of products" do
          client = Products.new
          response = client.index
          expect()
        end
      end
    end
  end
end
