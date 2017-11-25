module Api
  class ControllerRescuedError < BaseError

    def notify?
      true
    end

    def status
      super || 400
    end
  end
end
