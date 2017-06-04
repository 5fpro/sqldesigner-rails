require 'rails_helper'

RSpec.describe Api::BaseController, type: :request do
  it 'GET /api' do
    get '/api', params: { test: true }, xhr: true
    expect(response).to be_success
    expect(JSON.parse(response.body)['params']['test']).to eq('true')
  end

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

  it 'page not found' do
    get '/api/asdasda', xhr: true
    expect(JSON.parse(response.body)['name']).to eq('page_not_found')
    expect(response.status).to eq(404)
  end
end
