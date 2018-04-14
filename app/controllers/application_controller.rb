class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include TyrConcern
  enable_redactor2
  enable_paper_trail
  enable_basic_http_auth(env: :staging)
end
