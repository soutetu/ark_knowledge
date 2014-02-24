module SpecUtils
  def fixture_file_upload(path, type)
    Rack::Test::UploadedFile.new(File.join("spec/fixtures", path), type)
  end

  def default_password
    "84b63eefc9234094a0b76d2c16bda838a1bb936e28eb359c527a03d2094ce5d29c6e1cd5ca407a21e62c07cc79d60513c6ccd94639c58a1ca9689b41adad9577"
  end
end
