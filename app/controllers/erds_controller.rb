class ErdsController < ApplicationController
  before_filter :authenticate_user!
  def new
    render :layout => false
  end
end
