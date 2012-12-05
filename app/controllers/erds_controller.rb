class ErdsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    render :layout => false
  end

  def edit
    @erd = current_user.erds.find(params[:id])
  end

  def index
    @erds = current_user.erds
  end

  def list
    render :text => current_user.erds.select("keyword").order("id DESC").map{ |erd| erd.keyword }.join("\n")
  end

  def show
    if @erd = current_user.erds.find_by_keyword(CGI::unescape(params[:keyword]))
      render :text => @erd.data, :content_type => "text/xml"
    else
      render :text => "", :status => 404
    end
  end

  def create
    erd = current_user.erds.find_or_initialize_by_keyword(CGI::unescape(params[:keyword]))
    erd.data = request.raw_post
    status = erd.save ? 201 : 500
    render :text => "saved", :status => status
  end

  def update
    @erd = current_user.erds.find(params[:id])
    if @erd.update_attributes params[:erd]
      flash[:message] = "Updated"
      redirect_to erds_path
    else
      flash[:error] = @erd.errors.full_messages
      render :edit
    end
  end

  def destroy
    flash[:message] = "Deleted" if current_user.erds.find(params[:id]).destroy
    redirect_to erds_path
  end
end
