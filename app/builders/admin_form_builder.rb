class AdminFormBuilder < SimpleForm::FormBuilder
  def submit_cancel(*args, &block)
    out = ActiveSupport::SafeBuffer.new
    out << template.content_tag(:div, class: 'ln_solid') do
    end
    out << template.content_tag(:div, class: 'form-group') do
      template.content_tag :div, class: 'col-md-9 col-sm-9 col-xs-12 col-md-offset-3' do
        options = args.extract_options!
        options[:class] = [options[:class], 'btn btn-primary'].compact
        args << options
        if cancel = options.delete(:cancel)
          cancel_text = I18n.t('simple_form.buttons.cancel', default: 'Cancel')
          link = template.link_to(cancel_text, cancel, class: 'btn btn-default')
          submit(*args, &block) + '&nbsp;&nbsp;'.html_safe + link
        else
          submit(*args, &block)
        end
      end
    end
    out
  end

  def full_size_submit(text = nil)
    out = ActiveSupport::SafeBuffer.new
    out << template.content_tag(:div) do
      button :submit, text, class: 'btn btn-primary col-md-12 col-sm-12 col-xs-12'
    end
  end
end
