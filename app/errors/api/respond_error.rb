module Api
  class RespondError < BaseError

    def notify?
      false
    end

    def status
      super || 200
    end
  end
end
