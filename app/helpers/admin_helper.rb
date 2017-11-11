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

  def render_admin_sorting_buttons(instance, column: :sort, html_attrs: nil)
    scope = instance.class.to_s.split('::').last.underscore
    html = [:first, :up, :down, :last, :remove].map do |action|
      if action == :remove && instance.try(column).nil?
        ''
      else
        html_opts = {
          method: :put
        }.merge(html_attrs || {})
        link_to action.to_s.camelize, send("admin_#{scope}_path", instance, "#{scope}[#{column}]" => action, redirect_to: url_for), html_opts
      end
    end.select(&:present?).join(' | ')
    raw html
  end

  def menu_link(link)
    return link if link.to_s.index('http') == 0 || link.to_s.index('/') == 0
    public_send("#{link}_path")
  end

  def admin_stylesheet_links
    [
      '//colorlib.com/polygon/vendors/bootstrap/dist/css/bootstrap.min.css',
      '//colorlib.com/polygon/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css',
      '//colorlib.com/polygon/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css',
      '//colorlib.com/polygon/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css',
      '//colorlib.com/polygon/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css',
      '//colorlib.com/polygon/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css',
      '//colorlib.com/polygon/vendors/font-awesome/css/font-awesome.min.css',
      '//colorlib.com/polygon/vendors/nprogress/nprogress.css',
      '//colorlib.com/polygon/vendors/bootstrap-daterangepicker/daterangepicker.css',
      '//colorlib.com/polygon/vendors/switchery/dist/switchery.min.css',
      '//colorlib.com/polygon/vendors/iCheck/skins/flat/green.css',
      '//colorlib.com/polygon/vendors/select2/dist/css/select2.min.css',
      '//colorlib.com/polygon/build/css/custom.min.css'
    ]
  end

  def admin_javascript_links
    [
      '//colorlib.com/polygon/vendors/bootstrap/dist/js/bootstrap.min.js',
      '//colorlib.com/polygon/vendors/fastclick/lib/fastclick.js',
      '//colorlib.com/polygon/vendors/nprogress/nprogress.js',
      '//colorlib.com/polygon/vendors/Chart.js/dist/Chart.bundle.min.js',
      '//colorlib.com/polygon/vendors/Chart.js/dist/Chart.min.js',
      '//colorlib.com/polygon/vendors/jquery-sparkline/dist/jquery.sparkline.min.js',
      '//colorlib.com/polygon/vendors/Flot/jquery.flot.js',
      '//colorlib.com/polygon/vendors/Flot/jquery.flot.pie.js',
      '//colorlib.com/polygon/vendors/Flot/jquery.flot.time.js',
      '//colorlib.com/polygon/vendors/Flot/jquery.flot.stack.js',
      '//colorlib.com/polygon/vendors/Flot/jquery.flot.resize.js',
      '//colorlib.com/polygon/vendors/flot.orderbars/js/jquery.flot.orderBars.js',
      '//colorlib.com/polygon/vendors/flot-spline/js/jquery.flot.spline.min.js',
      '//colorlib.com/polygon/vendors/DateJS/build/date.js',
      '//colorlib.com/polygon/vendors/iCheck/icheck.min.js',
      '//colorlib.com/polygon/vendors/moment/min/moment.min.js',
      '//colorlib.com/polygon/vendors/bootstrap-daterangepicker/daterangepicker.js',
      '//colorlib.com/polygon/vendors/switchery/dist/switchery.min.js',
      '//colorlib.com/polygon/vendors/select2/dist/js/select2.full.min.js',
      '//colorlib.com/polygon/build/js/custom.min.js'

    ]
  end

  def admin_search_form_for(obj, options, &block)
    options ||= {}
    options.deep_merge!(builder: AdminFormBuilder, html: { class: 'form-horizontal' }, wrapper: :admin, defaults: { required: false })
    search_form_for(obj, options, &block)
  end

  def admin_form_for(obj, options = {}, &block)
    options ||= {}
    options.deep_merge!(builder: AdminFormBuilder, html: { class: 'form-horizontal' }, wrapper: :admin, defaults: { required: false })
    simple_form_for(obj, options, &block)
  end

  def render_admin_pagination(collection)
    render partial: 'admin/base/pagination', as: :collection, object: collection
  end

  def render_admin_data_table(data: nil, total: nil, bordered: true, striped: true, hover: true, &block)
    locals = {
      body: capture(data, &block),
      data: data,
      bordered: bordered,
      striped: striped,
      hover: hover,
      total: total
    }
    render partial: 'admin/base/data_table', locals: locals
  end

  def admin_link_to(text, link, icon: nil, size: nil, color: nil, round: false, **html_opts)
    html_opts ||= {}
    classes = html_opts[:class].to_s.split(' ')
    classes << 'btn'
    classes << { l: 'btn-lg', m: 'btn-sm', s: 'btn-xs' }[size.to_sym] if size
    classes << 'btn-round' if round
    classes << "btn-#{color}" if color
    html_opts[:class] = classes.select(&:present?).join(' ')
    link_to link, html_opts do
      text = "<i class=\"fa fa-#{icon}\"></i>&nbsp;#{text}" if icon
      text.html_safe
    end
  end

  def admin_app_button_to(text, link, icon: , **html_opts)
    html_opts ||= {}
    admin_link_to(text, link, icon: icon, class: "btn-app #{html_opts.delete(:class)}", **html_opts)
  end

  def admin_accordion(hash_data, &block)
    parent_id = 'accordion-parent' + hash_data.to_s.hash.to_s
    value = hash_data.map do |title, value|
      body = capture(title, value, &block)
      id = 'accordion' + "#{title}#{value}".hash.to_s
      render partial: 'admin/base/templates/accordion_item', locals: { title: title, body: body, id: id, parent_id: parent_id }
    end.join.html_safe
    render partial: 'admin/base/templates/accordion', locals: { content: value, id: parent_id }
  end
end
