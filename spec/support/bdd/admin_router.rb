require_relative 'base_router'

module Bdd
  class AdminRouter < BaseRouter
    def build_url(path)
      "/admin#{path}"
    end

    def build_env(options)
      { params: options }
    end
  end
end
