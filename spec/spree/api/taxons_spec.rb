require "spec_helper"

module Spree
  module API
    RSpec.describe Taxons do
      let(:client) { Taxons.new }

      describe "#index" do
        it "fetches a list of taxons given a taxonomy ID" do
          VCR.use_cassette("taxons/index") do
            response = client.index(taxonomy_id: 2)
            expect(response.status).to eq(200)
            expect(json(response)["taxons"]).not_to be_empty
          end
        end

        it "It returns 404(Not found)" do
          VCR.use_cassette("taxons/index/not_found") do
            response = client.index(taxonomy_id: 1)
            expect(response.status).to eq(404)
            expect(json(response)["error"])
              .to(eq("The resource you were looking for could not be found."))
          end
        end
      end

      describe "#show" do
        it "fetches a single taxon given a taxonomy ID" do
          VCR.use_cassette("taxons/show") do
            response = client.show(taxonomy_id: 2, id: 8)
            expect(response.status).to eq(200)
            expect(json(response)["name"]).to eq("Ruby")
          end
        end

        it "returns 404(Not found)" do
          VCR.use_cassette("taxons/show/not_found") do
            response = client.show(taxonomy_id: 2, id: 1)
            expect(response.status).to eq(404)
            expect(json(response)["error"])
              .to(eq("The resource you were looking for could not be found."))
          end
        end
      end

      describe "#create" do
        it "creates a new taxon given a taxonomy ID" do
          VCR.use_cassette("taxons/create") do
            response = client.create(taxonomy_id: 2,
              taxon: { taxon: { name: "The coolest taxon evar!" } })

            expect(response.status).to eq(201)
            expect(json(response)["name"]).to eq("The coolest taxon evar!")
          end
        end
      end

      describe "#update" do
        it "updates attributes on a taxon" do
          VCR.use_cassette("taxons/update") do
            response = client.update(taxonomy_id: 2, id: 9,
              taxon: { taxon: { name: "updated coolest taxon evar!" } })

            expect(response.status).to eq(200)
            expect(json(response)["name"]).to eq("updated coolest taxon evar!")
          end
        end
      end

      describe "#destroy" do
        it "updates attributes on a taxon" do
          VCR.use_cassette("taxons/destroy") do
            response = client.destroy(taxonomy_id: 2, id: 9)
            expect(response.status).to eq(204)
          end
        end
      end
    end
  end
end
