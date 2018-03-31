require 'rails_helper'

describe AttributesConcern, type: :value do
  class ExampleObject
    include AttributesConcern

    attr_accessor :a
    attr_reader   :b
    attr_writer   :c

    def to_h
      @b ||= 'b'
      d
      attributes
    end

    def d
      @d ||= 1
    end
  end

  it do
    o = ExampleObject.new(a: 'a', c: 'c')
    expect(o.to_h).to be_key(:a)
    expect(o.to_h).to be_key(:b)
    expect(o.to_h).not_to be_key(:c)
    expect(o.to_h).not_to be_key(:d)
  end
end
