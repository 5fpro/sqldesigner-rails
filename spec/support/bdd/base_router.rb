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
end
