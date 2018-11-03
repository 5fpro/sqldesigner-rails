module Admin
  class BaseController < Tyr::Admin::BaseController

    def index
      set_meta(title: { app_name: ENV['BRAND_NAME'] || ENV['APP_NAME'] })
    end

  end
end
