class DeviseBaseController < ApplicationController
  before_action :set_meta

  layout :layout_by_resource

  private

  def layout_by_resource
    # if resource_name == :user
    #
    # else
    'application'
    # end
  end
end
