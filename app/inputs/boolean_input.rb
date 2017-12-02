class BooleanInput < SimpleForm::Inputs::BooleanInput

  def input(_wrapper_options = nil)
    template.content_tag(:div, class: 'checkbox') do
      super(_wrapper_options)
    end
  end

  private

  def input_html_options
    super.merge(class: CssClass.new(super[:class]).add('flat').to_a)
  end

end
