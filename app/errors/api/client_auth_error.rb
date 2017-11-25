module Api
  class ClientAuthError < BaseError
    def notify?
      false
    end

    def status
      401
    end
  end
end
