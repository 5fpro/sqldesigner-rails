module ApplicationHelper
  def show_erd_path(erd)
    root_path(:keyword => erd.keyword, :user_id => erd.user_id)
  end

  def new_erd_path
    root_path
  end
end
