require "spec_helper"

module Refinery
  module API
    module Blog
      RSpec.describe Posts do
        let(:client) { Posts.new }

        describe "#index" do
          it "fetches a list of inquiries" do
            VCR.use_cassette("inquiries/inquiries/index") do
              response = client.index
              expect(response.status).to eq(200)
              expect(json(response)["inquiries"]).not_to be_empty
            end
          end
        end

        describe "#show" do
          it "fetches a single inquiry" do
            VCR.use_cassette("inquiries/inquiries/show") do
              response = client.show(id: 1)
              expect(response.status).to eq(200)
              expect(json(response)["name"]).to eq("test")
            end
          end

          it "returns 404(Not found)" do
            VCR.use_cassette("inquiries/inquiries/show/not_found") do
              response = client.show(id: 1000)
              expect(response.status).to eq(404)
              expect(json(response)["error"])
                .to(eq("The resource you were looking for could not be found."))
            end
          end
        end

        describe "#create" do
          it "creates a new inquiry" do
            VCR.use_cassette("inquiries/inquiries/create") do
              response = client.create(inquiry: { inquiry: { name: "John Doe", email: "refinery@example.org", message: "Hello world!" } })

              expect(response.status).to eq(201)
              expect(json(response)["name"]).to eq("John Doe")
            end
          end
        end

        describe "#destroy" do
          it "updates attributes on a inquiry" do
            VCR.use_cassette("inquiries/inquiries/destroy") do
              response = client.destroy(id: 2)
              expect(response.status).to eq(204)
            end
          end
        end
      end
    end
  end
end