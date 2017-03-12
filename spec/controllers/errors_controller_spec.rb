require 'rails_helper'

RSpec.describe ErrorsController, type: :request do
  it '/404' do
    get '/dasdasdasd'
    expect(response.status).to eq(404)
    expect(response.body).to include('looking for doesn\'t exist.')
  end
end
