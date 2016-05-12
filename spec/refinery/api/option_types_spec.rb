require "spec_helper"

module Refinery
  module API
    RSpec.describe OptionTypes do
      let(:client) { OptionTypes.new }
      let(:payload) do
        { "option_type" => {
            "name" => "coolness",
            "presentation" => "Level"
          }
        }
      end

      describe "#index" do
        it "pulls available option types" do
          VCR.use_cassette("options_types/index") do
            response = client.index
            expect(response.status).to eq(200)
            expect(json(response).first["name"]).to eq("tshirt-size")
          end
        end
      end

      describe "#show" do
        it "pulls a single option type given its ID" do
          VCR.use_cassette("options_types/show") do
            response = client.show(id: 1)
            expect(response.status).to eq(200)
            expect(json(response)["name"]).to eq("tshirt-size")
          end
        end
      end

      describe "#create" do
        it "creates a new option type" do
          VCR.use_cassette("options_types/create") do
            response = client.create(option_type: payload)
            expect(response.status).to eq(201)
            expect(json(response)["name"]).to eq("coolness")
          end
        end
      end

      describe "#put" do
        it "updates attributes on a given option type" do
          VCR.use_cassette("options_types/update") do
            response = client.update(id: 3,
              option_type: { option_type: { name: "coolness updated" } })

            expect(response.status).to eq(200)
            expect(json(response)["name"]).to eq("coolness updated")
          end
        end
      end

      describe "#destroy" do
        it "deletes a given option type" do
          VCR.use_cassette("options_types/destroy") do
            response = client.destroy(id: 3)
            expect(response.status).to eq(204)
          end
        end
      end
    end
  end
end
