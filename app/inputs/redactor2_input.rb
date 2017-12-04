# example in view:
#   f.input :some_attribute, as: :redactor2
class Redactor2Input < SimpleForm::Inputs::TextInput

  private

  def input_html_options
    super.merge(class: CssClass.new(super[:class]).add('js-redactor').to_a)
  end

end
