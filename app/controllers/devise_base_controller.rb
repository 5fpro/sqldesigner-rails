class DeviseBaseController < ApplicationController
  before_action :set_meta

  layout :layout_by_resource

  private

  def flash_if_has_error
    unless resource.errors.empty?
      flash.now[:error] = resource.errors.full_messages.to_sentence
    end
  end

  def layout_by_resource
    if [:user, :administrator].include?(resource_name)
      'admin_landing'
    else
      'application'
    end
  end
end
