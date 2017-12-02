class Redactor2RailsFileUploader < BaseUploader
  include Redactor2Rails::Backend::CarrierWave

  def extension_white_list
    Redactor2Rails.files_file_types
  end
end
