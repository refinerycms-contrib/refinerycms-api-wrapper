require "spec_helper"

module Spree
  module API
    RSpec.describe OptionValues do
      let(:client) { OptionValues.new }
      let(:payload) do
        {
          option_value: {
            name: "Huge",
            presentation: "H"
          }
        }
      end

      describe "#create" do
        it "creates a new option value given a option type id" do
          VCR.use_cassette("option_values/create") do
            response = client.create(option_type_id: 1, option_value: payload)
            expect(response.status).to eq(201)
            expect(json(response)["name"]).to eq("Huge")
          end
        end
      end

      describe "#destroy" do
        it "deletes a option value given its ID" do
          VCR.use_cassette("option_values/destroy") do
            response = client.destroy(option_type_id: 1, id: 3)
            expect(response.status).to eq(204)
          end
        end
      end

      describe "#update" do
        it "updates attributes on a option value" do
          VCR.use_cassette("option_values/update") do
            response = client.update(option_type_id: 1, id: 2, option_value: {
              option_value: { name: "tiny" } })

            expect(response.status).to eq(200)
            expect(json(response)["name"]).to eq("tiny")
          end
        end
      end
    end
  end
end
