class ImageUploader < BaseUploader
  enable_image_processor!

  version :thumb do
    process resize_and_pad: [200, 200]
  end

  def extension_white_list
    ['jpg', 'jpeg', 'png', 'gif', 'tiff', 'svg']
  end
end
