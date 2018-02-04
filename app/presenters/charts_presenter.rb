class ChartsPresenter

  CHART_TYPES = %w[bar bubble doughnut horizontal_bar line pie polar_area radar scatter].freeze

  class << self
    private

    def element_id
      @element_id ||= -1
      @element_id += 1
    end
  end

  # http://www.chartjs.org/docs/latest/general/
  def initialize(type, data, options)
    @type = type
    @data = data
    @options = options
    @element_id = @options.delete(:id)     || "chart-#{self.class.send(:element_id)}"
    @css_class  = @options.delete(:class)  || 'chart'
    @width      = @options.delete(:width)  || '400'
    @height     = @options.delete(:height) || '400'
  end

  def to_html
    "#{canvas}<script>#{to_js}</script>".html_safe
  end

  private

  def to_js
    <<-JSBLOCK.squish.html_safe
    (function() {
          var initChart = function() {
            var ctx = document.getElementById(#{@element_id.to_json});
            var chart = new Chart(ctx, {
              type:    "#{camel_case(@type)}",
              data:    #{to_javascript_string @data},
              options: #{to_javascript_string @options}
            });
          };
          if (typeof Chart !== "undefined" && Chart !== null) {
            initChart();
          }
          else {
            /* W3C standard */
            if (window.addEventListener) {
              window.addEventListener("load", initChart, false);
            }
            /* IE */
            else if (window.attachEvent) {
              window.attachEvent("onload", initChart);
            }
          }
        })();
    JSBLOCK
  end

  def canvas
    "<canvas id=\"#{@element_id}\" class=\"#{@css_class}\" width=\"#{@width}\" height=\"#{@height}\" style=\"width: #{@width}; height: #{@height}\"></canvas>"
  end

  def camel_case(str)
    str = str.to_s.camelize
    str[0] = str[0].downcase
    str
  end

  def to_javascript_string(element)
    case element
    when Hash
      hash_elements = []
      element.each do |key, value|
        hash_elements << camel_case(key).to_json + ':' + to_javascript_string(value)
      end
      '{' + hash_elements.join(',') + '}'
    when Array
      array_elements = []
      element.each do |value|
        array_elements << to_javascript_string(value)
      end
      '[' + array_elements.join(',') + ']'
    when String
      if element.match?(/^\s*function.*}\s*$/m)
        # Raw-copy function definitions to the output without surrounding quotes.
        element
      else
        element.to_json
      end
    when BigDecimal
      element.to_s
    else
      element.to_json
    end
  end
end
