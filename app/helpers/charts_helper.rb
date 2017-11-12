module ChartsHelper
  ChartsPresenter::CHART_TYPES.each do |chart_type|
    define_method "render_#{chart_type}_chart" do |data, options = {}|
      ChartsPresenter.new(chart_type, data, options).to_html
    end
  end
end
