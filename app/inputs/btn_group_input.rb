class BtnGroupInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  include AdminRadiosInputConcern

  # https://github.com/plataformatec/simple_form/blob/master/lib/simple_form/inputs/collection_radio_buttons_input.rb
  def input(_wrapper_options = nil)
    label_method, value_method = detect_collection_methods
    template.content_tag(:div, class: 'btn-group', 'data-toggle' => 'buttons') do
      collection.map do |item|
        value = item.send(value_method)
        checked = value.to_s == @builder.object.send(attribute_name).to_s
        input_name = "#{@builder.object_name}[#{attribute_name}]"
        template.content_tag(:label, class: "btn btn-default #{checked ? 'active' : ''}") do
          [
            "<input type=\"radio\" name=\"#{input_name}\" value=\"#{value}\" #{checked ? 'checked="yes"' : ''} />",
            item.send(label_method)
          ].join.html_safe
        end
      end.join.html_safe
    end
  end

end
