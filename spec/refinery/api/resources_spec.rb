require "spec_helper"

module Refinery
  module API
    RSpec.describe Resources do
      let(:client) { Resources.new }

      describe "#index" do
        it "fetches a list of resources" do
          VCR.use_cassette("resources/index") do
            response = client.index
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["resources"]).not_to be_empty
          end
        end
      end

      describe "#create" do
        pending
      end

      describe "#show" do
        it "retrieves a given resource's attributes" do
          VCR.use_cassette("resources/show") do
            response = client.show(id: 1)
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["resource_title"]).to eq("")
          end
        end
      end

      describe "#update" do
        it "updates attributes on the given resource" do
          VCR.use_cassette("resources/update") do
            response = client.update(id: 1,
              resource: { resource: { resource_title: "Cool updated" } })

            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["resource_title"]).to eq("Cool updated")
          end
        end
      end

      describe "#destroy" do
        it "destroy a given resource" do
          VCR.use_cassette("resources/destroy") do
            response = client.destroy(id: 1)
            expect(response.status).to eq(204)
          end
        end
      end
    end
  end
end
