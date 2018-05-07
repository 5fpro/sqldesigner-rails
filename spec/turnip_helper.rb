Turnip.type = :request
require 'rails_helper'
require 'tyr/rspec/turnip'
Dir[Rails.root.join('spec', 'steps', '**', '*_steps.rb')].each { |f| load f }

Bdd::DataMap.append!(Rails.root.join('spec', 'fixtures', 'turnip.yml'))

RSpec.configure do |config|
  config.raise_error_for_unimplemented_steps = true
end
