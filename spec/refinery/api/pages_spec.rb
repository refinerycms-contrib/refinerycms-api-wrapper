require "spec_helper"

module Refinery
  module API
    RSpec.describe Pages do
      let(:client) { Pages.new }

      describe "#index" do
        it "fetches a list of pages" do
          VCR.use_cassette("pages/index") do
            response = client.index
            expect(response.status).to eq(200)
            expect(json(response)["pages"]).not_to be_empty
          end
        end
      end

      describe "#show" do
        it "fetches a single page" do
          VCR.use_cassette("pages/show") do
            response = client.show(id: 1)
            expect(response.status).to eq(200)
            expect(json(response)["title"]).to eq("test")
          end
        end

        it "returns 404(Not found)" do
          VCR.use_cassette("pages/show/not_found") do
            response = client.show(id: 1000)
            expect(response.status).to eq(404)
            expect(json(response)["error"])
              .to(eq("The resource you were looking for could not be found."))
          end
        end
      end

      describe "#create" do
        it "creates a new page" do
          VCR.use_cassette("pages/create") do
            response = client.create(page: { page: { title: "The coolest page evar!" } })

            expect(response.status).to eq(201)
            expect(json(response)["title"]).to eq("The coolest page evar!")
          end
        end
      end

      describe "#update" do
        it "updates attributes on a page" do
          VCR.use_cassette("pages/update") do
            response = client.update(id: 2,
              page: { page: { title: "updated coolest page evar!" } }
            )

            expect(response.status).to eq(200)
            expect(json(response)["title"]).to eq("updated coolest page evar!")
          end
        end
      end

      describe "#destroy" do
        it "destroy a given page" do
          VCR.use_cassette("pages/destroy") do
            response = client.destroy(id: 2)
            expect(response.status).to eq(204)
          end
        end
      end
    end
  end
end