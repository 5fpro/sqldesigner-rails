require 'rails_helper'

describe BaseForm, type: :form do
  class ExampleForm < BaseForm
    attr_accessor :name
    validates :name, presence: true

    def save
      if valid?
        true
      else
        false
      end
    end
  end

  it do
    form = ExampleForm.new(name: '')
    expect(form.save).to eq(false)
  end
end
