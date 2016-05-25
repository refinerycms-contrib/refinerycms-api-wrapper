require "spec_helper"

module Refinery
  module API
    RSpec.describe Resources do
      let(:client) { Resources.new }
      let(:payload) do
        { "product" => {
            "name" => "Cool name", "price" => 100, "shipping_category_id" => 1
          }
        }
      end

      describe "#index" do
        it "fetches a list of resources" do
          VCR.use_cassette("resources/index") do
            response = client.index
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["resources"]).not_to be_empty
          end
        end
      end

      # describe "#product_attributes" do
      #   it "fetches attributes needed to create a product" do
      #     VCR.use_cassette("products/attributes") do
      #       response = client.product_attributes

      #       expect(response.status).to eq(200)
      #       expect(JSON.parse(response.body)["attributes"])
      #         .to(include("id", "name", "price"))

      #       expect(JSON.parse(response.body)["required_attributes"])
      #         .to(include("name", "price", "shipping_category_id"))
      #     end
      #   end
      # end

      # describe "#create" do
      #   it "creates a product" do
      #     VCR.use_cassette("products/create") do
      #       response = client.create(product: payload)
      #       expect(response.status).to eq(201)
      #       expect(JSON.parse(response.body)["name"]).to eq("Cool name")
      #     end
      #   end

      #   it "returns errors when payload is invalid" do
      #     VCR.use_cassette("products/create/invalid") do
      #       response = client.create(product: payload["product"].update(name: ""))
      #       expect(response.status).to eq(422)

      #       expect(JSON.parse(response.body)["errors"]["name"])
      #         .to(include("can't be blank"))
      #     end
      #   end
      # end

      describe "#show", focus: true do
        it "retrieves a given resource's attributes" do
          VCR.use_cassette("resources/show") do
            response = client.show(id: 1)
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["resource_title"]).to eq("")
          end
        end
      end

      # describe "#update" do
      #   it "updates attributes on the given product" do
      #     VCR.use_cassette("products/update") do
      #       response = client.update(id: 10,
      #         product: { product: { name: "Cool updated" } })

      #       expect(response.status).to eq(200)
      #       expect(JSON.parse(response.body)["name"]).to eq("Cool updated")
      #     end
      #   end

      #   it "returns errors if the payload is not valid" do
      #     VCR.use_cassette("products/update/invalid") do
      #       response = client.update(id: 9,
      #         product: { product: { name: "" } })

      #       expect(response.status).to eq(422)
      #       expect(JSON.parse(response.body)["errors"]["name"])
      #         .to(include("can't be blank"))
      #     end
      #   end
      # end

      # describe "#delete" do
      #   it "deletes a given product" do
      #     VCR.use_cassette("products/delete") do
      #       response = client.delete(id: 10)
      #       expect(response.status).to eq(204)
      #     end
      #   end
      # end
    end
  end
end
