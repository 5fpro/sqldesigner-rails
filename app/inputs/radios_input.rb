class RadiosInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  include AdminRadiosInputConcern

  def input(wrapper_options = nil)
    wrapper_options = (wrapper_options || {}).merge(
      include_blank: false
    )
    @input_type = 'radio_buttons'
    super(wrapper_options)
  end

  private

  def input_html_options
    super.merge(class: CssClass.new(super[:class]).add('flat').to_a)
  end

end
