module Api
  class BaseController < ::ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :accept_cors
    before_action :set_default_format

    include ::Api::ErrorResponseHandler

    def index
      render json: { ok: true, params: params.permit(params.keys).to_h }
    end

    def error
      Error.raise!(params.require(:error), messages: 'Error object test', data: params.permit(params.keys).to_h)
    end

    private

    def accept_cors
      headers['Access-Control-Allow-Origin']    = '*'
      headers['Access-Control-Allow-Methods']   = 'GET, POST, PUT, DELETE'
      headers['Access-Control-Allow-Headers']   = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport, X-Remote, api_key, auth_token, *'
      headers['Access-Control-Request-Method']  = 'GET, POST, PUT, DELETE'
      headers['Access-Control-Request-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport,  X-Remote, api_key, *'
    end

    def set_default_format
      request.format = 'json'
    end

  end
end
