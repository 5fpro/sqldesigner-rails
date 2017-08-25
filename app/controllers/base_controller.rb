class BaseController < ApplicationController
  before_action :set_meta

  def index
    set_meta(title: 'haha', description: 'HAHA', url: 'https://www.www')
  end
end
