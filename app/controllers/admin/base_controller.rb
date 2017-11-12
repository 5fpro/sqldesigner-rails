class Admin::BaseController < ApplicationController
  layout 'admin'
  respond_to :html, :json, :csv

  before_action :authenticate_user!
  before_action :authenticate_admin_user!
  before_action :set_meta

  add_breadcrumb 'Admin', :admin_root_path

  def index
    @page_title = 'Admin'
    set_meta(title: "#{ENV['APP_NAME']} Admin")
  end

  def examples
    @page_title = 'Template Examples'
    add_breadcrumb 'Examples'
    set_meta(title: @page_title)
  end

  def error
    @page_title = '404 Not Found'
    render layout: 'error'
  end

  private

  def authenticate_admin_user!
    redirect_to root_path unless current_user.admin?
  end
end
