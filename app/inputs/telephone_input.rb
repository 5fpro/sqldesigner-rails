class TelephoneInput < SimpleForm::Inputs::StringInput

  private

  def input_html_options
    super.merge(
      class: CssClass.new(super[:class]).add('js-intl-tel').to_a,
      'data-intl-tel': (@options[:js_options] || {}).to_json
    )
  end

end
