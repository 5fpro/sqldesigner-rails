require 'rails_helper'

describe CssClass, type: :value do
  it do
    expect(described_class.new(nil).add('a').to_s).to eq('a')
    expect(described_class.new('a b').add('c a', 'd e').to_s).to eq('a b c d e')
    expect(described_class.new(['a ', 'b ']).add(['c  ', '  d'], nil, '', ['e'], 'f g').to_s).to eq('a b c d e f g')
  end
end
