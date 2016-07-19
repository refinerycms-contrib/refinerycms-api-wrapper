require "spec_helper"

module Refinery
  module API
    module Blog
      RSpec.describe Posts do
        let(:client) { Posts.new }

        describe "#create" do
          it "creates a new post" do
            VCR.use_cassette("blog/posts/create") do
              response = client.create(post: { 
                post: { 
                  title: "The coolest post evar!",
                  body: "The coolest body evar!",
                  published_at: Date.today,
                  username: "Bob"
                } 
              })

              expect(response.status).to eq(201)
              expect(json(response)["title"]).to eq("The coolest post evar!")
            end
          end
        end

        describe "#index" do
          it "fetches a list of blog posts" do
            VCR.use_cassette("blog/posts/index") do
              response = client.index
              expect(response.status).to eq(200)
              expect(json(response)["posts"]).not_to be_empty
            end
          end
        end

        describe "#show" do
          it "fetches a single post" do
            VCR.use_cassette("blog/posts/show") do
              response = client.show(id: 1)
              expect(response.status).to eq(200)
              expect(json(response)["title"]).to eq("The coolest post evar!")
            end
          end

          it "returns 404(Not found)" do
            VCR.use_cassette("blog/posts/show/not_found") do
              response = client.show(id: 1000)
              expect(response.status).to eq(404)
              expect(json(response)["error"])
                .to(eq("The resource you were looking for could not be found."))
            end
          end
        end

        # describe "#create" do
        #   it "creates a new post" do
        #     VCR.use_cassette("blog/posts/create") do
        #       response = client.create(post: { post: { title: "The coolest post evar!" } })

        #       expect(response.status).to eq(201)
        #       expect(json(response)["title"]).to eq("The coolest post evar!")
        #     end
        #   end
        # end

        describe "#update" do
          it "updates attributes on a post" do
            VCR.use_cassette("blog/posts/update") do
              response = client.update(id: 1,
                post: { post: { title: "updated coolest post evar!" } }
              )

              expect(response.status).to eq(200)
              expect(json(response)["title"]).to eq("updated coolest post evar!")
            end
          end
        end

        describe "#destroy" do
          it "updates attributes on a post" do
            VCR.use_cassette("blog/posts/destroy") do
              response = client.destroy(id: 1)
              expect(response.status).to eq(204)
            end
          end
        end
      end
    end
  end
end