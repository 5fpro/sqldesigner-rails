module Api
  module ErrorResponseConcern
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError do |e|
        respond_with_error Api::ControllerRescuedError.new(status: 500, original: e)
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        respond_with_error Api::ControllerRescuedError.new(status: 404, original: e)
      end

      rescue_from ActionController::ParameterMissing do |e|
        respond_with_error Api::ControllerRescuedError.new(status: 400, original: e)
      end

      rescue_from ::RoutingError do |e|
        respond_with_error Api::ControllerRescuedError.new(status: 404, original: e)
      end

      rescue_from Api::BaseError do |e|
        respond_with_error(e)
      end

    end

    private

    def respond_with_error(error)
      @error = error
      @error.log
      @error.notify if @error.notify?
      render 'api/base/error', status: @error.status
    end

    def respond_error(message: nil, status: 200, **context)
      raise Api::RespondError.new(context: context, message: message, status: status)
    end

  end
end
