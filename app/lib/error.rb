class Error
  class << self
    def raise!(name, messages: nil, data: {})
      unless Errors::Code.exists?(name)
        data[:ori_error_name] = name
        name = :error_code_not_defined
      end
      messages ||= [Errors::Code.desc(name)]
      messages = [] unless messages.is_a?(Array)
      data[:messages_json] = messages.to_json
      raise Errors::Exception.new(name, data), messages.join("\n")
    end
  end
end
