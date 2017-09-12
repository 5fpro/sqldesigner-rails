class ErrorsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def not_found
    respond_to do |format|
      format.json { render json: { message: 'Page not found' }, status: 404 }
      format.html { render status: 404 }
      format.any { render plain: 'Page not found', status: 404 }
    end
  end

  def internal_server_error
    respond_to do |format|
      format.json { render json: { message: 'Internal Server Error' }, status: 500 }
      format.html { render status: 500 }
      format.any { render plain: 'Internal Server Error', status: 500 }
    end
  end
end
