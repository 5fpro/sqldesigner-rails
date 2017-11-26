module Bdd
  class BaseRouter
    class << self
      delegate :build_env, :build_url, to: :default

      def default
        @default ||= new
      end
    end

    def build_url(_path)
      raise NotImplementedError
    end

    def build_env(_options)
      raise NotImplementedError
    end

  end

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

  class AdminRouter < BaseRouter
    def build_url(path)
      "/admin#{path}"
    end

    def build_env(options)
      { params: options }
    end
  end

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
