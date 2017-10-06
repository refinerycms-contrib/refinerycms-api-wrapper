require "spec_helper"

module Refinery
  module API
    RSpec.describe Images do
      let(:client) { Images.new }

      describe "#create" do
        it "creates a image" do
          VCR.use_cassette("images/create") do
            response = client.create(image: { image: { image: [Faraday::UploadIO.new(file_path('thinking-cat.jpg'), 'image/jpg')], image_title: "Kitty" } })

            expect(response.status).to eq(201)
            expect(JSON.parse(response.body)["image_title"]).to eq("Kitty")
          end
        end

        # it "returns errors when payload is invalid" do
        #   VCR.use_cassette("products/create/invalid") do
        #     response = client.create(product: payload["product"].update(name: ""))
        #     expect(response.status).to eq(422)

        #     expect(JSON.parse(response.body)["errors"]["name"])
        #       .to(include("can't be blank"))
        #   end
        # end
      end

      describe "#index" do
        it "fetches a list of images" do
          VCR.use_cassette("images/index") do
            response = client.index
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["images"]).not_to be_empty
          end
        end
      end

      describe "#show" do
        it "retrieves a given image's attributes" do
          VCR.use_cassette("images/show") do
            response = client.show(id: 1)
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["image_title"]).to eq("entreprise")
          end
        end
      end

      describe "#update" do
        it "updates attributes on the given image" do
          VCR.use_cassette("images/update") do
            response = client.update(id: 1,
              image: { image: { image_title: "Cool updated" } })

            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["image_title"]).to eq("Cool updated")
          end
        end
      end

      describe "#delete" do
        it "deletes a given image" do
          VCR.use_cassette("images/destroy") do
            response = client.destroy(id: 1)
            expect(response.status).to eq(204)
          end
        end
      end
    end
  end
end
