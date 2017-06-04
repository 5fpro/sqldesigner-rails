require 'rails_helper'

RSpec.describe Api::BaseController, type: :request do
  it 'GET /api' do
    get '/api', params: { test: true }, xhr: true
    expect(response).to be_success
    expect(JSON.parse(response.body)['params']['test']).to eq('true')
  end
end
