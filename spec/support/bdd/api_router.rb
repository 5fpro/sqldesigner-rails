module Bdd

  class ApiRouter < BaseRouter
    def build_url(path)
      "/api#{path}"
    end

    def build_env(options)
      options = options.with_indifferent_access
      options = { params: options } if !options.key?(:params) && !options.key?(:headers)
      options[:xhr] = true
      options
    end
  end

end
