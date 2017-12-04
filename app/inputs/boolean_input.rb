class BooleanInput < SimpleForm::Inputs::BooleanInput

  def input(*args)
    template.content_tag(:div, class: 'checkbox') do
      super(*args)
    end
  end

  private

  def input_html_options
    super.merge(class: CssClass.new(super[:class]).add('flat').to_a)
  end

end
