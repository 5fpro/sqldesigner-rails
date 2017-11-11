class RadiosInput < SimpleForm::Inputs::CollectionRadioButtonsInput

  def input(wrapper_options = nil)
    wrapper_options = (wrapper_options || {}).merge(
      include_blank: false,
      wrapper: :admin_radios
    )
    @input_type = 'radio_buttons'
    super(wrapper_options)
  end

end
