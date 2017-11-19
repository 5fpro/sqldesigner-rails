require 'rails_helper'

describe BaseValidator, type: :validator do
  class ExampleValidator < BaseValidator
    def validate(form)
      form.errors.add(:base, 'Name can\'t be blank.') if form.name.blank?
    end
  end

  class ExampleForm < BaseForm
    validates_with ExampleValidator

    attr_accessor :name
  end

  it do
    form = ExampleForm.new(name: '')
    expect(form.valid?).to eq(false)
  end
end
