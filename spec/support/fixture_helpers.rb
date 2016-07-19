module Fixtures
  module Helper
    def file_path(filename)
      File.open(File.expand_path(File.dirname(__FILE__)) + '/fixtures/' + filename)
    end

    def upload_file(filename, mime_type)
      Rack::Test::UploadedFile.new(file_path(filename).path, mime_type)
    end
  end
end





