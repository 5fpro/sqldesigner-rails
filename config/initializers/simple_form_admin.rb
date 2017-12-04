# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_class = 'alert alert-danger'
  config.button_class = 'btn btn-default'
  config.boolean_label_class = nil

  config.wrappers :admin, tag: :div, class: 'form-group', error_class: 'parsley-error' do |b|
    b.use :placeholder
    b.use :label, class: 'control-label'
    b.wrapper tag: :div, class: '' do |ba|
      ba.use :input, class: 'form-control', wrap_with: nil, error_class: 'parsley-error'
      # ba.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :error, wrap_with: { tag: 'span', class: 'parsley-errors-list filled' }
    end
  end

  config.wrappers :admin_landing, tag: :div, class: '', error_class: 'parsley-error' do |b|
    b.use :placeholder
    # b.use :label, class: ''
    b.use :input, class: 'form-control', wrap_with: nil, error_class: 'parsley-error'
  end
end

