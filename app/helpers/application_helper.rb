module ApplicationHelper
  def show_erd_path(erd)
    root_path(:keyword => erd.keyword)
  end

  def new_erd_path
    root_path
  end
end
