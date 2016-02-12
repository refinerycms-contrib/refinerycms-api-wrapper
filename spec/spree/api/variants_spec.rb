require "spec_helper"

module Spree
  module API
    RSpec.describe Variants do
      let(:client) { Variants.new }
      let(:payload) do
        {
          variant: {
            price: 12.00,
            sku: "1234"
          }
        }
      end

      describe "#index" do
        it "gets a variant list" do
          VCR.use_cassette("variants/index") do
            response = client.index
            expect(response.status).to eq(200)
            expect(json(response)["variants"]).not_to be_empty
          end
        end

        it "gets a variant list specific to a product" do
          VCR.use_cassette("variants/index/filtered") do
            response = client.index(product_id: 9)
            expect(response.status).to eq(200)

            expect(json(response)["variants"].first["name"])
              .to(eq("Ruby on Rails Stein"))
          end
        end
      end

      describe "#show" do
        it "gets a single variant for the given product" do
          VCR.use_cassette("variants/show") do
            response = client.show(product_id: 7, id: 22)
            expect(response.status).to eq(200)

            expect(json(response)["name"])
              .to(eq("Apache Baseball Jersey"))
          end
        end

        it "returns not found message when sending an unexisting variant" do
          VCR.use_cassette("variants/show/not_found") do
            response = client.show(product_id: 7, id: 1)
            expect(response.status).to eq(404)

            expect(json(response)["error"])
              .to(eq("The resource you were looking for could not be found."))
          end
        end
      end

      describe "#new" do
        it "fetches attributes(required and non-required) for variant creation" do
          VCR.use_cassette("variants/new") do
            response = client.new(product_id: 7)
            expect(response.status).to eq(200)
            expect(json(response)["attributes"]).to include("id", "name", "sku", "price")
            expect(json(response)["required_attributes"]).to be_empty
          end
        end
      end

      describe "#create" do
        it "creates a product variant" do
          VCR.use_cassette("variants/create") do
            response = client.create(variant: payload, product_id: 7)
            expect(response.status).to eq(201)
            expect(json(response)["sku"]).to eq("1234")
          end
        end
      end

      describe "#update" do
        it "updates attributes on the given variant" do
          VCR.use_cassette("variants/update") do
            response = client.update(variant: {
              variant: { sku: "4321" } }, product_id: 7, id: 22)

            expect(response.status).to eq(200)
            expect(json(response)["sku"]).to eq("4321")
          end
        end
      end

      describe "#destroy" do
        it "deletes the given variant" do
          VCR.use_cassette("variants/destroy") do
            response = client.destroy(product_id: 7, id: 24)
            expect(response.status).to eq(204)
          end
        end

        it "returns not found message" do
          VCR.use_cassette("variants/destroy/not_found") do
            response = client.destroy(product_id: 7, id: 24)
            expect(response.status).to eq(404)

            expect(json(response)["error"])
              .to(eq("The resource you were looking for could not be found."))
          end
        end
      end
    end
  end
end
