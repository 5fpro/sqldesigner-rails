class Backend::RailsController < ApplicationController

  def index
    render :text => params.inspect
  end

  def list
    render :text => Erd.select("keyword").order("id DESC").map{ |erd| erd.keyword }.join("\n")
  end

  def save
    erd = Erd.find_or_initialize_by_keyword(params[:keyword])
    erd.data = request.raw_post
    status = erd.save ? 201 : 500
    render :text => "saved", :status => status
  end

  def load
    if erd = Erd.find_by_keyword(params[:keyword])
      render :text => erd.data, :content_type => "text/xml"
    else
      render :text => "", :status => 404
    end
  end

end