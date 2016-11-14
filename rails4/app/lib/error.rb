class Error
  class << self
    def raise!(key, message: nil, data: {})
      message ||= Errors::Code.desc(key)
      raise Errors::Exception.new(key, data), message
    end
  end
end
