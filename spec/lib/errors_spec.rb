require 'rails_helper'

describe ::Error, type: :lib do
  it '.raise' do
    expect {
      described_class.raise!(:data_not_found)
    }.to raise_error(::Errors::Exception)
  end
end
