require 'rails_helper'

describe ObjectErrorsConcern, type: :error do
  class ExmapleClass
    include ObjectErrorsConcern

    attr_accessor :name, :email
  end

  let(:instance) { ExmapleClass.new }

  before do
    instance.errors.add :base, :taken, message: 'Haha'
    instance.errors.add :name, :taken
    instance.errors.add :email, :not_found, message: 'NotFF'
  end

  it '#error?' do
    expect(instance.error?).to eq(true)
    expect(instance.error?(:base, :taken)).to eq(true)
    expect(instance.error?(:name, :taken)).to eq(true)
    expect(instance.error?(:email, :taken)).to eq(false)
    expect(instance.error?(:any, :taken)).to eq(true)
    expect(instance.error?(:any, :not_found)).to eq(true)
    expect(instance.error?(:abc)).to eq(false)
    expect(instance.error?(:abc, :def)).to eq(false)
  end

  it '#errors=' do
    instance2 = ExmapleClass.new
    instance2.errors = instance.errors
    expect(instance2.error?(:base, :taken)).to eq(true)
  end

  it '#error_message' do
    expect(instance.error_message).to be_present
    expect(instance.error_message(:base)).to include('Haha')
    expect(instance.error_message(:name)).to include('taken')
    expect(instance.error_message(:email)).to include('NotFF')
  end
end
