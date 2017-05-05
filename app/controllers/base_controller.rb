class BaseController < ApplicationController

  def index
    set_meta(title: ENV['APP_NAME'])
  end
end
