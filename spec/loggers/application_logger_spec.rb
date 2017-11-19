require 'rails_helper'

describe ApplicationLogger, type: :logger do

  it do
    expect(described_class.log(a: 1, b: 2)).to be_present
    expect(described_class.error(a: 1, b: 2)).to be_present
    expect(described_class.error('haha')).to be_present
    expect(described_class.info(a: 1, b: 2)).to be_present
    expect(described_class.info('haha')).to be_present
    expect(described_class.debug(a: 1, b: 2)).to be_present
    expect(described_class.debug('haha')).to be_present
  end

  describe 'ExampleLogger' do
    let(:file) { Rails.root.join('log', 'example.log') }

    class ExampleLogger < ApplicationLogger
      file_path Rails.root.join('log', 'example.log')
    end

    before { File.delete(file) if File.exists?(file) }

    it do
      expect {
        ExampleLogger.debug(ha: 1)
      }.to change { File.exists?(file) }.to(true)
      File.delete(file)
    end
  end

end
