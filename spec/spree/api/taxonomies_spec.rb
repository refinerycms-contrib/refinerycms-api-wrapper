require "spec_helper"

module Spree
  module API
    RSpec.describe Taxonomies do
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

      describe "#taxon_create" do
        it "creates a taxon for the given taxonomy" do
          VCR.use_cassette("taxonomies/taxons/create") do
            response = client.taxon_create(taxonomy_id: 5, taxon: {
              taxon: { name: "Optimus" }
            })

            expect(response.status).to eq(201)
            expect(json(response)["name"]).to eq("Optimus")
          end
        end

        it "returns errors when taxon is not valid" do
          VCR.use_cassette("taxonomies/taxons/create/invalid") do
            response = client.taxon_create(taxonomy_id: 5, taxon: {
              taxon: { name: "" }
            })

            expect(response.status).to eq(422)
            expect(json(response)["errors"]["name"]).to eq(["can't be blank"])
          end
        end
      end

      describe "#taxon_list" do
        it "fetches a taxon list for a given taxonomy" do
          VCR.use_cassette("taxonomies/taxons/index") do
            response = client.taxon_list(taxonomy_id: 5)
            expect(response.status).to eq(200)
            expect(json(response)["taxons"].first["name"]).to eq("Megatron")
          end
        end
      end

      describe "#taxon_update" do
        it "updates the name of a given taxon" do
          VCR.use_cassette("taxonomies/taxons/update") do
            response = client.taxon_update(taxonomy_id: 5, taxon_id: 16,
              taxon: { taxon: { name: "Bumblebee" } })

            expect(response.status).to eq(200)
            expect(json(response)["name"]).to eq("Bumblebee")
          end
        end
      end

      describe "#taxon_destroy" do
        it "deletes the given taxon" do
          VCR.use_cassette("taxonomies/taxons/destroy") do
            response = client.taxon_destroy(taxonomy_id: 5, taxon_id: 18)
            expect(response.status).to eq(204)
          end
        end
      end
    end
  end
end
