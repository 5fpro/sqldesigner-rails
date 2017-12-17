class AvatarUploader < BaseUploader
  enable_background_upload!
  enable_image_processor!

  version :thumb do
    process resize_to_fit: [50, 50]
  end
end
