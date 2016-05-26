module Fixtures
  module Helper
    def upload_file(filename)
      IO.read(File.dirname(__FILE__) + '/fixtures/' + filename)
    end
  end
end





