module Requests
  module JsonHelper
    def json(response)
      JSON.parse(response.body)
    end
  end
end
