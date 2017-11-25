module Api
  class ControllerRescuedError < ::Api::BaseError

    def notify?
      true
    end

    def status
      super || 400
    end
  end
end
