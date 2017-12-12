require 'rails_helper'

class ExampleController < ActionController::Base; end

describe Api::ErrorResponseConcern, type: :controller do
  render_views

  controller(ExampleController) do
    include Api::ErrorResponseConcern

    def params_required
      params.require(:test)
    end

    def record_not_found
      User.find(123_123)
    end

    def error_500
      nil.abc
    end

    def render_error
      respond_error(message: 'qq', status: 401, haha: 'haha', type: '123')
    end

    def routing_error
      raise RoutingError.new(request: request)
    end
  end

  before {
    routes.draw {
      get 'params_required' => 'example#params_required'
      get 'record_not_found' => 'example#record_not_found'
      get 'error_500' => 'example#error_500'
      get 'respond_error' => 'example#render_error'
      get 'routing_error' => 'example#routing_error'
    }
  }

  let(:data) { JSON.parse(response.body).with_indifferent_access }

  describe 'ActionController::ParameterMissing' do
    before { get :params_required, format: :json }
    it do
      expect(response.status).to eq(400)
      expect(data[:error][:class_name]).to be_present
      expect(data[:error][:original]).to be_present
      expect(data[:error][:backtrace]).to be_present
      expect(data[:error][:message]).to be_present
    end
  end

  describe 'ActiveRecord::RecordNotFound' do
    before { get :record_not_found, format: :json }
    it do
      expect(response.status).to eq(404)
      expect(data[:error][:class_name]).to be_present
      expect(data[:error][:original]).to be_present
      expect(data[:error][:backtrace]).to be_present
      expect(data[:error][:message]).to be_present
    end
  end

  describe 'StandardError' do
    it do
      get :error_500, format: :json
      expect(response.status).to eq(500)
      expect(data[:error][:class_name]).to be_present
      expect(data[:error][:original]).to be_present
      expect(data[:error][:backtrace]).to be_present
      expect(data[:error][:message]).to be_present
    end

    it 'notified' do
      expect_any_instance_of(Api::ControllerRescuedError).to receive(:notify)
      get :error_500, format: :json
    end
  end

  describe 'render_error' do
    before { get :render_error, format: :json }
    it do
      expect(response.status).to eq(401)
      expect(data[:error][:context][:haha]).to eq('haha')
      expect(data[:error][:class_name]).to be_present
      expect(data[:error][:message]).to be_present
    end
  end

  describe 'routing_error' do
    it do
      get :routing_error, format: :json
      expect(response.status).to eq(404)
      expect(data[:error][:class_name]).to be_present
      expect(data[:error][:message]).to be_present
    end

    it 'not notified' do
      expect_any_instance_of(Api::ControllerRescuedError).not_to receive(:notify)
      get :routing_error, format: :json
    end
  end

end
