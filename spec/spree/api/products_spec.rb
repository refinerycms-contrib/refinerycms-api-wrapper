require "spec_helper"

module Spree
  module API
    RSpec.describe Products do
      before do
        Spree::API.configure do |conf|
          conf.api_token = "d3d1038e9338436c2db1e9ca597ef31b430e937aef90fba6"
          conf.api_url = "http://localhost:3000"
        end
      end

      let(:client) { Products.new }
      let(:payload) do
        { "product" => {
            "name" => "Cool name", "price" => 100, "shipping_category_id" => 1
          }
        }
      end

      describe "#index" do
        it "fetches a list of products" do
          VCR.use_cassette("products/index") do
            response = client.index
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["products"]).not_to be_empty
          end
        end
      end

      describe "#product_attributes" do
        it "fetches attributes needed to create a product" do
          VCR.use_cassette("products/attributes") do
            response = client.product_attributes

            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["attributes"])
              .to(include("id", "name", "price"))

            expect(JSON.parse(response.body)["required_attributes"])
              .to(include("name", "price", "shipping_category_id"))
          end
        end
      end

      describe "#create" do
        it "creates a product" do
          VCR.use_cassette("products/create") do
            response = client.create(product: payload)
            expect(response.status).to eq(201)
            expect(JSON.parse(response.body)["name"]).to eq("Cool name")
          end
        end

        it "returns errors when payload is invalid" do
          VCR.use_cassette("products/create/invalid") do
            response = client.create(product: payload["product"].update(name: ""))
            expect(response.status).to eq(422)

            expect(JSON.parse(response.body)["errors"]["name"])
              .to(include("can't be blank"))
          end
        end
      end

      describe "#show" do
        it "retrieves a given product's attributes" do
          VCR.use_cassette("products/show") do
            response = client.show(id: 10)
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["name"]).to eq("Cool name")
          end
        end
      end

      describe "#update" do
        it "updates attributes on the given product" do
          VCR.use_cassette("products/update") do
            response = client.update(id: 10,
              product: { product: { name: "Cool updated" } })

            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["name"]).to eq("Cool updated")
          end
        end

        it "returns errors if the payload is not valid" do
          VCR.use_cassette("products/update/invalid") do
            response = client.update(id: 9,
              product: { product: { name: "" } })

            expect(response.status).to eq(422)
            expect(JSON.parse(response.body)["errors"]["name"])
              .to(include("can't be blank"))
          end
        end
      end

      describe "#delete" do
        it "deletes a given product" do
          VCR.use_cassette("products/delete") do
            response = client.delete(id: 10)
            expect(response.status).to eq(204)
          end
        end
      end
    end
  end
end
