module Api
  class ControllerRescuedError < BaseError
    DONT_NOTIFIED_ERRORS = [
      ::RoutingError,
      ActionController::ParameterMissing
    ].freeze

    def notify?
      !DONT_NOTIFIED_ERRORS.include?(@original.class)
    end

    def status
      super || 400
    end
  end
end
