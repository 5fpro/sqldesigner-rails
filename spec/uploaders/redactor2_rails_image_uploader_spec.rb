require 'rails_helper'

describe Redactor2RailsImageUploader, type: :uploader do
  let(:instance) { Redactor2Rails::Image.new }
  it do
    uploader = Redactor2RailsImageUploader.new(instance)
    file_path = Rails.root.join('spec', 'fixtures', '5fpro.png')
    File.open(file_path) { |f| uploader.store!(f) }
    expect(File.exist?(uploader.file.file)).to eq(true)
    File.unlink(uploader.file.file)
  end
end
