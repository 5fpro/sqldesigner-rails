class Admin::BaseController < ApplicationController
  layout 'admin'
  respond_to :html, :json, :csv

  before_action :authenticate_administrator!
  before_action :set_meta

  add_breadcrumb breadcrumb_text, :admin_root_path

  def index
    set_meta(title: { app_name: ENV['APP_NAME'] })
  end

  def examples
    add_breadcrumb t('.breadcrumb')
  end

  def error
    render layout: 'error'
  end

  private

  def authenticate_root_administrator!
    unless current_administrator&.root?
      redirect_to admin_root_path, flash: { error: t('.authenticate_root_administrator.error', default: t('controllers.custom.authenticate_root_administrator')) }
    end
  end
end
