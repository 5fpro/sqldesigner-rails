class ErrorsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def not_found
    respond_to do |format|
      format.json { render json: { message: t('.message') }, status: 404 }
      format.html { render status: 404 }
      format.any { render plain: t('.message'), status: 404 }
    end
  end

  def internal_server_error
    respond_to do |format|
      format.json { render json: { message: t('.message') }, status: 500 }
      format.html { render status: 500 }
      format.any { render plain: t('.message'), status: 500 }
    end
  end
end
