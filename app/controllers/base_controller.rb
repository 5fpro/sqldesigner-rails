class BaseController < ApplicationController
  before_action :set_meta

  def index; end

  def version
    respond_to do |f|
      f.html { render html: AppRevision.log.to_s }
      f.text { render text: AppRevision.log.to_s }
      f.json { render json: AppRevision.to_h }
    end
  end
end
