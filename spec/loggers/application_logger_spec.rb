require 'rails_helper'

describe ApplicationLogger, type: :logger do

  it do
    expect(described_class.default).to be_present
    expect(described_class.default.file_path).to be_present
  end
end
