module Bdd
  class ApplicationRouter < BaseRouter
    def build_url(path)
      path
    end

    def build_env(options)
      options = options.with_indifferent_access
      options = { params: options } if !options.key?(:params) && !options.key?(:headers)
      options
    end
  end
end
