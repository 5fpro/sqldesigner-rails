module Api
  class BaseController < Tyr::Api::BaseController
    skip_before_action :tyr_http_auth, raise: false

    def index
      redirect_to 'https://api-doc.5fpro.com'
    end

    def error
      respond_error message: 'test error'
    end
  end
end
