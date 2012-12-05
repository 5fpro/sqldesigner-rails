class ErdsController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :edit, :new, :create, :update, :destroy]

  def new
    render :layout => false
  end

  def edit
    @erd = current_user.erds.find(params[:id])
  end

  def revisions
    @erd = current_user.erds.find(params[:id])
    @erds = @erd.full_history
  end

  def index
    @erds = current_user.erds
    respond_to do |f|
      f.html
      f.xml { render_erds_list(@erds) }
    end
  end

  def show
    @erd = Erd.find params[:id]
    @erd = @erd.versions[params[:version].to_i].reify if params[:version]
    respond_to do |f|
      f.html { render :new, :layout => false }
      f.xml { render_erd_xml(@erd) }
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

  private

  def render_erd_xml(erd)
    if erd.published? || (user_signed_in? && current_user.id == erd.user_id)
      render :text => erd.data, :content_type => "text/xml"
    else
      render :text => "", :status => 404
    end
  end

  def render_erds_list(erds)
    render :text => erds.select("keyword").order("id DESC").map{ |erd| erd.keyword }.join("\n")
  end

end
