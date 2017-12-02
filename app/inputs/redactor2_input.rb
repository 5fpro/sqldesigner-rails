class Redactor2Input < SimpleForm::Inputs::TextInput
  def input(wrapper_options = nil)
    wrapper_options ||= {}
    wrapper_options[:class] = "#{wrapper_options[:class]} redactor"
    super(wrapper_options)
  end
end
