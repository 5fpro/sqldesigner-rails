class NestedSwitchInput < SimpleForm::Inputs::BooleanInput
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options.deep_merge(class: 'js-switch'), wrapper_options)
    outs = []
    outs << build_hidden_field_for_checkbox
    outs << template.label_tag(nil, class: 'checkbox') do
      (build_check_box_without_hidden_field(merged_input_options) +
      '&nbsp;'.html_safe +
      label_text)
    end
    outs.join('').html_safe
  end
end
