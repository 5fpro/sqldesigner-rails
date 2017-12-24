require 'rails_helper'

describe BaseForm, type: :form do
  class ExampleForm < BaseForm
    attr_accessor :name, :ha
    validates :name, :ha, presence: true

    before_validation :default_ha
    validate :valid_ha

    def save
      !error?
    end

    private

    def default_ha
      @ha ||= '123'
    end

    def valid_ha
      errors.add(:ha, :invalid, message: 'ha can\'t be x') if ha == 'x'
    end
  end

  it do
    form = ExampleForm.new(name: '')
    expect(form.save).to eq(false)
    expect(form.ha).to eq('123')

    form = ExampleForm.new(name: '123', ha: 'x')
    expect(form.save).to eq(false)
    expect(form.error?(:ha, :invalid)).to eq(true)

    expect {
      ExampleForm.new(name: '123', ha: 'x', zz: '123')
    }.to raise_error(ActiveModel::UnknownAttributeError)
  end
end
