module AdminHelper
  def admin_widget_box(title, icon: nil, &block)
    render partial: 'admin/base/widget_box', locals: { main: capture(&block), title: title, icon: icon }
  end

  def convert_changes_string(string, hstore_columns: nil)
    return {} unless string
    hstore_columns ||= ['data']
    diffs = YAML.safe_load(string)
    hstore_columns.each do |hstore_col|
      next unless data = diffs.delete(hstore_col)
      HashDiff.diff(data[0] || {}, data[1] || {}).each do |diff|
        diffs[diff[1]] = [diff[2], diff[3]] if diff[0] == '~'
      end
    end
    diffs
  end

  def collection_for_delete_state
    [['Deleted', :only_deleted], ['All', :with_deleted]]
  end

  def collection_for_tags
    Tag.all.map(&:name)
  end

  def render_admin_sorting_buttons(instance, column: :sort)
    scope = instance.class.to_s.split('::').last.underscore
    html = [:first, :up, :down, :last, :remove].map do |action|
      if action == :remove && instance.try(column).nil?
        ''
      else
        link_to action.to_s.camelize, send("admin_#{scope}_path", instance, "#{scope}[#{column}]" => action, redirect_to: url_for), method: :put, class: 'btn btn-mini'
      end
    end.join(' ')
    raw html
  end
end
