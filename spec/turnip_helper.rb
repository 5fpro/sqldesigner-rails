Turnip.type = :request
require 'rails_helper'
Dir[Rails.root.join('spec', 'steps', '**', '*_steps.rb')].each { |f| load f }
include FactoryBot::Syntax::Methods

RSpec.configure do |config|
  config.raise_error_for_unimplemented_steps = true

  config.include FactoryBot::Syntax::Methods
  config.include RequestClient, type: :request
end
