class BaseController < ApplicationController
  before_action :set_meta

  def index; end

  def version
    respond_to do |f|
      f.html { render html: Revision.log.to_s }
      f.text { render text: Revision.log.to_s }
      f.json { render json: Revision.to_h }
    end
  end
end
