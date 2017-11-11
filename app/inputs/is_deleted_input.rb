class IsDeletedInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  # TODO: i18n
  def input(wrapper_options = nil)
    wrapper_options = (wrapper_options || {}).merge(
      include_blank: false,
      wrapper: :admin_radio
    )
    @input_type = 'radio_buttons'
    super(wrapper_options)
  end

  private

  def collection
    [['Not Deleted', ''], ['Deleted', :only_deleted], ['All', :with_deleted]]
  end

  def label_text(*args)
    'Deleted'
  end
end
