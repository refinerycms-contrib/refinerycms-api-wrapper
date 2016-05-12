require "spec_helper"

module Refinery
  module API
    RSpec.describe Pages do
      let(:client) { Pages.new }
      let(:payload) do
        { "page" => {
            "title" => "test 1"
          }
        }
      end

      describe "#index" do
        it "fetches a list of pages" do
          VCR.use_cassette("pages/index") do
            response = client.index
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["pages"]).not_to be_empty
          end
        end
      end

      describe "#show" do
        it "retrieves a given page's attributes" do
          VCR.use_cassette("pages/show") do
            response = client.show(id: 1)
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["title"]).to eq("Cool name")
          end
        end
      end

    end
  end
end
