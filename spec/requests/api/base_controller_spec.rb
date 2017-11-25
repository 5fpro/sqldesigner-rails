require 'rails_helper'

RSpec.describe Api::BaseController, type: :request do

  context 'GET /error' do
    it 'standard' do
      get '/api/error', xhr: true
      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)['error']['class_name']).to eq('Api::ClientAuthError')
      expect(JSON.parse(response.body)['error']['message']).to include('authenticate fail')
    end

    it '404' do
      get '/api/haha', xhr: true
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['error']['class_name']).to eq('RoutingError')
      expect(JSON.parse(response.body)['error']['original']['request']['full_path']).to include('/haha')
    end
  end
end
