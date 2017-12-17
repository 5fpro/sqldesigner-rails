class BaseUploader < CarrierWave::Uploader::Base
  class << self
    private

    def enable_background_upload!
      include ::CarrierWave::Backgrounder::Delay
    end

    def enable_image_processor!
      include CarrierWave::MiniMagick
    end
  end

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage Rails.env.test? ? :file : :fog

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def filename
    if original_filename.present?
      "#{secure_token}#{file.extension.present? ? '.' + file.extension : ''}"
    end
  end

  def store_dir
    if model?
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{id_partition(model)}"
    else
      "uploads/#{self.class.to_s.underscore}"
    end
  end

  private

  def secure_token
    if model?
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
    else
      SecureRandom.uuid
    end
  end

  def id_partition(attachment)
    case id = attachment.id
    when Integer
      format('%09d', id).scan(/\d{3}/).join('/')
    when String
      id.scan(/.{3}/).first(3).join('/')
    end
  end

  def model?
    model.respond_to?(:id)
  end
end
