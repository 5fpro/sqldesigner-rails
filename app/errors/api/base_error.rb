module Api
  class BaseError < ApplicationError

    # Override method
    def notify?
      false
    end

    # Override method
    attr_reader :status

    private

    def custom_initialize(status: nil)
      @status = status
    end

    def custom_to_h
      {
        status: status
      }
    end
  end
end
