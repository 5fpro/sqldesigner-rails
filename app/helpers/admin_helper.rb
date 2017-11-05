module AdminHelper
  def admin_widget_box(title, &block)
    render partial: 'admin/base/widget_box', locals: { body: capture(&block), title: title }
  end

  def append_page_button(body, link, options = {})
    klasses = ['btn', 'btn-default', 'btn-lg'] + options[:class].to_s.split(' ')
    options[:class] = klasses.select(&:present?).uniq
    content_for :btns do
      link_to body, link, options
    end
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

  def menu_link(link)
    return link if link.to_s.index('http') == 0 || link.to_s.index('/') == 0
    public_send("#{link}_path")
  end

  def admin_stylesheet_links
    [
      'https://colorlib.com/polygon/vendors/bootstrap/dist/css/bootstrap.min.css',
      'https://colorlib.com/polygon/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css',
      'https://colorlib.com/polygon/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css',
      'https://colorlib.com/polygon/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css',
      'https://colorlib.com/polygon/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css',
      'https://colorlib.com/polygon/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css',
      'https://colorlib.com/polygon/vendors/font-awesome/css/font-awesome.min.css',
      'https://colorlib.com/polygon/vendors/nprogress/nprogress.css',
      'https://colorlib.com/polygon/vendors/bootstrap-daterangepicker/daterangepicker.css',
      'https://colorlib.com/polygon/vendors/switchery/dist/switchery.min.css',
      'https://colorlib.com/polygon/vendors/iCheck/skins/flat/green.css',
      'https://colorlib.com/polygon/build/css/custom.min.css'
    ]
  end

  def admin_javascript_links
    [
      'https://colorlib.com/polygon/vendors/bootstrap/dist/js/bootstrap.min.js',
      'https://colorlib.com/polygon/vendors/fastclick/lib/fastclick.js',
      'https://colorlib.com/polygon/vendors/nprogress/nprogress.js',
      'https://colorlib.com/polygon/vendors/Chart.js/dist/Chart.min.js',
      'https://colorlib.com/polygon/vendors/jquery-sparkline/dist/jquery.sparkline.min.js',
      'https://colorlib.com/polygon/vendors/Flot/jquery.flot.js',
      'https://colorlib.com/polygon/vendors/Flot/jquery.flot.pie.js',
      'https://colorlib.com/polygon/vendors/Flot/jquery.flot.time.js',
      'https://colorlib.com/polygon/vendors/Flot/jquery.flot.stack.js',
      'https://colorlib.com/polygon/vendors/Flot/jquery.flot.resize.js',
      'https://colorlib.com/polygon/vendors/flot.orderbars/js/jquery.flot.orderBars.js',
      'https://colorlib.com/polygon/vendors/flot-spline/js/jquery.flot.spline.min.js',
      'https://colorlib.com/polygon/vendors/DateJS/build/date.js',
      'https://colorlib.com/polygon/vendors/iCheck/icheck.min.js',
      'https://colorlib.com/polygon/vendors/moment/min/moment.min.js',
      'https://colorlib.com/polygon/vendors/bootstrap-daterangepicker/daterangepicker.js',
      'https://colorlib.com/polygon/vendors/switchery/dist/switchery.min.js',
      'https://colorlib.com/polygon/build/js/custom.min.js'

    ]
  end

  def admin_search_form_for(obj, options, &block)
    options ||= {}
    options.deep_merge!(builder: AdminFormBuilder, html: { class: 'form-horizontal' }, wrapper: :admin, defaults: { required: false })
    search_form_for(obj, options, &block)
  end

  def admin_form_for(obj, options, &block)
    options ||= {}
    options.deep_merge!(builder: AdminFormBuilder, html: { class: 'form-horizontal' }, wrapper: :admin, defaults: { required: false })
    simple_form_for(obj, options, &block)
  end

  def render_admin_pagination(collection)
    render partial: 'admin/base/pagination', as: :collection, object: collection
  end

  def render_admin_data_table(data: nil, total: nil, bordered: true, striped: true, hover: true, &block)
    locals = {
      body: capture(&block),
      data: data,
      bordered: bordered,
      striped: striped,
      hover: hover,
      total: total
    }
    render partial: 'admin/base/data_table', locals: locals
  end
end
