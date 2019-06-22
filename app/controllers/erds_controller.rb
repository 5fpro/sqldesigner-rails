class ErdsController < ApplicationController

  skip_before_action :verify_authenticity_token, raise: false
  before_action :authenticate_user!, only: [:index, :edit, :new, :create, :update, :destroy]
  before_action :set_meta
  layout 'tyr_admin_landing'

  def new
    render layout: false
  end

  def edit
    @erd = current_user.erds.find(params[:id])
    set_meta(title: { keyword: @erd.keyword })
  end

  def revisions
    @erd = current_user.erds.find(params[:id])
    set_meta(title: { keyword: @erd.keyword })
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
      f.html { render :new, layout: false }
      f.xml { render_erd_xml(@erd) }
    end
  end

  def create
    erd = current_user.erds.find_or_initialize_by(keyword: CGI.unescape(params[:keyword]))
    erd.data = CGI.unescape(request.raw_post)
    erd.save!
    render plain: 'saved', status: :ok
  end

  def update
    @erd = current_user.erds.find(params[:id])
    if @erd.update(params.require(:erd).permit(:keyword, :is_published))
      flash[:message] = 'Updated'
      redirect_to erds_path
    else
      flash[:error] = @erd.errors.full_messages
      render :edit
    end
  end

  def destroy
    flash[:message] = 'Deleted' if current_user.erds.find(params[:id]).destroy
    redirect_to erds_path
  end

  private

  def render_erd_xml(erd)
    if erd.published? || (user_signed_in? && current_user.id == erd.user_id)
      render plain: erd.data, content_type: 'text/xml'
    else
      render plain: '', status: :not_found
    end
  end

  def render_erds_list(erds)
    render plain: erds.select('keyword').order('id DESC').map(&:keyword).join("\n")
  end

end
