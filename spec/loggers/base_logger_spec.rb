require 'rails_helper'

describe BaseLogger, type: :logger do

  it do
    expect(described_class.log(a: 1, b: 2)).to be_present
    expect(described_class.error(a: 1, b: 2)).to be_present
    expect(described_class.error('haha')).to be_present
    expect(described_class.info(a: 1, b: 2)).to be_present
    expect(described_class.info('haha')).to be_present
    expect(described_class.debug(a: 1, b: 2)).to be_present
    expect(described_class.debug('haha')).to be_present
    expect(described_class.debug(a: "a\nb")).not_to include("\n")
  end

  describe 'ExampleLogger' do
    let(:file) { Rails.root.join('log', 'example.log') }

    class ExampleLogger < BaseLogger
      file_path Rails.root.join('log', 'example.log')
    end

    before { File.delete(file) if File.exist?(file) }

    it do
      expect {
        ExampleLogger.debug(ha: 1)
      }.to change { File.exist?(file) }.to(true)
      File.delete(file)
    end
  end

end
