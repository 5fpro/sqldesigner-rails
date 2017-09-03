require 'rails_helper'

RSpec.describe ErrorsController, type: :request do
  context '/404' do
    it 'html format' do
      get '/dasdasdasd'
      expect(response.status).to eq(404)
      expect(response.body).to include('looking for doesn\'t exist.')
    end

    it 'json format' do
      get '/not_a_valid_url.json'
      expect(response.status).to eq(404)
      response_json = JSON.parse(response.body)
      expect(response_json['message']).to eq('Page not found')
    end

    it 'other format' do
      get '/not_a_valid_url.test'
      expect(response.status).to eq(404)
      expect(response.body).to include('Page not found')
    end
  end
end
