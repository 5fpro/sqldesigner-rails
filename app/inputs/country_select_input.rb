class CountrySelectInput < SimpleForm::Inputs::StringInput

  private

  def input_html_options
    super.merge(
      class: CssClass.new(super[:class]).add('js-country-select').to_a,
      'data-country-select': (@options[:js_options] || {}).to_json
    )
  end

end
