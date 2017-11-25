module Api
  class ClientAuthError < ::Api::BaseError
    def notify?
      false
    end

    def status
      401
    end
  end
end
