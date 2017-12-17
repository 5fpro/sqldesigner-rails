require 'rails_helper'

describe BaseUploader, type: :uploader do
  class ExampleUploader < BaseUploader

  end

  it do
    uploader = ExampleUploader.new
    file_path = Rails.root.join('.ruby-version')
    File.open(file_path) { |f| uploader.store!(f) }
    expect(File.exist?(uploader.file.file)).to eq(true)
    File.unlink(uploader.file.file)
  end
end
