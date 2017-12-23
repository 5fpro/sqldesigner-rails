class Redactor2RailsImageUploader < BaseUploader
  include Redactor2Rails::Backend::CarrierWave
  enable_image_processor!

  process :read_dimensions

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fill: [100, 100]
  end

  version :content do
    process resize_to_limit: [800, 800]
  end

  def extension_white_list
    Redactor2Rails.images_file_types
  end

end
