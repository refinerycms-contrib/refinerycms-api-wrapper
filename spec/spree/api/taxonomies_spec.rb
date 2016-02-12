require "spec_helper"

module Spree
  module API
    describe Taxonomies do
      before do
        Spree::API.configure do |conf|
          conf.api_token = "d3d1038e9338436c2db1e9ca597ef31b430e937aef90fba6"
          conf.api_url = "http://localhost:3000"
          conf.api_path = "/shop/api"
        end
      end

      let(:client) { Taxonomies.new }

      describe "#index" do
        it "fetches a list of taxonomies" do
          VCR.use_cassette("taxonomies/index") do
            response = client.index
            expect(response.status).to eq(200)
            expect(json(response)["taxonomies"]).not_to be_empty
          end
        end
      end

      describe "#show" do
        it "fetches a single taxonomy given an id" do
          VCR.use_cassette("taxonomies/show") do
            response = client.show(id: 1)
            expect(response.status).to eq(200)
            expect(json(response)["id"]).to eq(1)
          end
        end
      end

      describe "#create" do
        it "creates a taxonomy" do
          VCR.use_cassette("taxonomies/create") do
            response = client.create(taxonomy: { taxonomy: { name: "Bruh" } })
            expect(response.status).to eq(201)
            expect(json(response)["name"]).to eq("Bruh")
          end
        end

        it "returns errors if the payload is not valid" do
          VCR.use_cassette("taxonomies/create/with_errors") do
            response = client.create(taxonomy: { taxonomy: { name: nil } })
            expect(response.status).to eq(422)
            expect(json(response)["errors"]["name"]).to include("can't be blank")
          end
        end
      end

      describe "#update" do
        it "updates attributes on a taxonomy given an id" do
          VCR.use_cassette("taxonomies/update") do
            response = client.update(taxonomy: {
              taxonomy: { name: "Updated Bruh" } }, id: 5)

            expect(response.status).to eq(200)
            expect(json(response)["name"]).to eq("Updated Bruh")
          end
        end

        it "returns errors if the payload is not valid" do
          VCR.use_cassette("taxonomies/update/with_errors") do
            response = client.update(taxonomy: {
              taxonomy: { name: nil } }, id: 5)

            expect(response.status).to eq(422)
            expect(json(response)["errors"]["name"]).to include("can't be blank")
          end
        end
      end

      describe "#destroy" do
        it "deletes a taxonomy" do
          VCR.use_cassette("taxonomies/destroy") do
            response = client.destroy(id: 1)
            expect(response.status).to eq(204)
          end
        end
      end
    end
  end
end
