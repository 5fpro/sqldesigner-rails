# example in view:
#   f.input :some_attribute, as: :redactor2
class Redactor2Input < SimpleForm::Inputs::TextInput
  def input(wrapper_options = nil)
    wrapper_options ||= {}
    wrapper_options[:class] = "#{wrapper_options[:class]} js-redactor"
    super(wrapper_options)
  end
end
