require 'rails_helper'

describe ErrorHandler, type: :concern do
  let(:klass) do
    Class.new do
      include ErrorHandler
      attr_reader :email, :name
    end
  end

  before { Klass = klass unless defined?(Klass) }

  it '#has_error?' do
    instance = Klass.new
    instance.errors.add :base, :taken
    instance.errors.add :name, :taken
    instance.errors.add :email, :not_found
    expect(instance.has_error?(:taken)).to eq(true)
    expect(instance.has_error?(:not_found)).to eq(true)
    expect(instance.has_error?(:abc)).to eq(false)
    expect(instance.has_error?(:not_found, attr: :email)).to eq(true)
    expect(instance.has_error?(:not_found, attr: :name)).to eq(false)
  end

  it '#errors=' do
    instance = Klass.new
    instance.errors.add :base, :taken
    instance2 = Klass.new
    instance2.errors = instance.errors
    expect(instance2.has_error?(:taken)).to eq(true)
  end
end
