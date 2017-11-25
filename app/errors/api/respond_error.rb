module Api
  class RespondError < ::Api::BaseError

    def notify?
      false
    end

    def status
      super || 200
    end
  end
end
