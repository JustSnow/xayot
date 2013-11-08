class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/bg/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    Rails.root+"/rails.png"
  end

  version :thumb do
    process :resize_to_limit => [200, 200]
  end
end