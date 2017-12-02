class Select2Input < SimpleForm::Inputs::CollectionSelectInput

  def input_options
    return super.merge(include_blank: false) if multiple?
    super
  end

  private

  # TODO: more attrs for select2
  def input_html_options
    super.merge(class: CssClass.new(super[:class]).add('js-select2').to_a)
  end
end
