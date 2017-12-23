require 'rails_helper'

describe AvatarUploader, type: :uploader do
  let(:user) { create(:user) }
  it do
    uploader = described_class.new(user)
    file_path = Rails.root.join('spec', 'fixtures', '5fpro.png')
    File.open(file_path) { |f| uploader.store!(f) }
    expect(File.exist?(uploader.file.file)).to eq(true)
    File.unlink(uploader.file.file)
  end
end
