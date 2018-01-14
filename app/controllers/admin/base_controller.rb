class Admin::BaseController < ApplicationController
  layout 'admin'
  respond_to :html, :json, :csv

  before_action :authenticate_administrator!
  before_action :set_meta

  add_breadcrumb 'Admin', :admin_root_path

  def index
    set_meta(title: "#{ENV['APP_NAME']} Admin")
  end

  def examples
    add_breadcrumb 'Examples'
    set_meta(title: 'Template Examples')
  end

  def error
    set_meta(title: '404 Not Found')
    render layout: 'error'
  end

  private

  def authenticate_root_administrator!
    unless current_administrator&.root?
      redirect_to admin_root_path, flash: { error: 'No permission.' }
    end
  end
end
