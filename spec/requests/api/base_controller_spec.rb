require 'rails_helper'

RSpec.describe Api::BaseController, type: :request do

  context 'GET /error' do
    it 'standard' do
      get '/api/error', params: { error: 'data_create_fail' }, xhr: true
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)['name']).to eq('data_create_fail')
    end

    it '404' do
      get '/api/error', params: { error: 'data_not_found' }, xhr: true
      expect(response.status).to eq(404)
    end

    it 'error name not exists' do
      get '/api/error', params: { error: 'dasdasd' }, xhr: true
      expect(JSON.parse(response.body)['name']).to eq('error_code_not_defined')
      expect(JSON.parse(response.body)['debug']['info']['ori_error_name']).to eq('dasdasd')
      expect(response.status).to eq(400)
    end

  end
end
