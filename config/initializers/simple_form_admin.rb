# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_class = 'alert alert-danger'
  config.button_class = 'btn btn-default'
  config.boolean_label_class = nil

  config.wrappers :admin, tag: :div, class: 'form-group', error_class: 'parsley-error' do |b|
    b.use :placeholder
    b.use :label, class: 'control-label col-md-3 col-sm-3 col-xs-12'
    b.wrapper tag: :div, class: 'col-md-9 col-sm-9 col-xs-12' do |ba|
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

  config.wrappers :admin_boolean, tag: :div, class: 'form-group', error_class: 'parsley-error' do |b|
    b.use :label, class: 'control-label col-md-3 col-sm-3 col-xs-12'
    b.wrapper tag: :div, class: 'col-md-9 col-sm-9 col-xs-12' do |ba|
      ba.wrapper tag: :div, class: 'checkbox' do |bba|
        bba.use :input, class: 'flat'
      end
    end
  end

  config.wrappers :admin_boolean_switch, tag: :div, class: 'form-group', error_class: 'parsley-error' do |b|
    b.use :label, class: 'control-label col-md-3 col-sm-3 col-xs-12'
    b.wrapper tag: :div, class: 'col-md-9 col-sm-9 col-xs-12' do |ba|
      ba.wrapper tag: :div, class: 'checkbox' do |bba|
        bba.use :input, class: 'js-switch'
      end
    end
  end

  config.wrappers :admin_radios, tag: :div, class: 'form-group', error_class: 'parsley-error' do |b|
    b.use :label, class: 'control-label col-md-3 col-sm-3 col-xs-12'
    b.wrapper tag: :div, class: 'col-md-9 col-sm-9 col-xs-12' do |ba|
      ba.use :input, class: 'flat', wrap_with: { tag: 'div', class: 'radio' }
    end
  end

  config.wrapper_mappings = {
    boolean: :admin_boolean,
    switch: :admin_boolean_switch,
    radios: :admin_radios
  }
end

