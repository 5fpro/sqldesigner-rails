module Api
  class BaseError < ::BaseError

    # Override method
    def notify?
      false
    end

    # Override method
    def status
      @status
    end

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
