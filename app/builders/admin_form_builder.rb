class AdminFormBuilder < SimpleForm::FormBuilder
  attr_reader :label_wrapper_class
  # admin_form_for(...., rwd: [11, 11, 12])
  def initialize(*)
    super
    handle_rwd_with!
  end

  def label(*args)
    class_name = CssClass.new(args.extract_options![:class]).add(@label_wrapper_class).to_s
    super(*merge_args_options(args, class: class_name))
  end

  def submit_cancel(*args, &block)
    out = ActiveSupport::SafeBuffer.new
    out << template.content_tag(:div, class: 'ln_solid') do
    end
    out << template.content_tag(:div, class: 'form-group') do
      label = template.content_tag :div, class: @label_wrapper_class do
      end
      input = template.content_tag :div, class: @input_wrapper_class do
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
      (label + input).html_safe
    end
    out
  end

  def full_size_submit(text = nil)
    out = ActiveSupport::SafeBuffer.new
    out << template.content_tag(:div) do
      button :submit, text, class: 'btn btn-primary col-md-12 col-sm-12 col-xs-12'
    end
  end

  private

  def merge_args_options(args, opts)
    if args.last.is_a?(Hash)
      args[-1].deep_merge!(opts)
    else
      args << opts
    end
    args
  end

  def handle_rwd_with!
    max = 12
    rwd_width = options.delete(:rwd) || [9, 9, max]
    @label_wrapper_class = CssClass.new(options[:label_wrapper_class]).add("col-md-#{max - rwd_width[0]}", "col-sm-#{max - rwd_width[1]}", "col-xs-#{rwd_width[2] == max ? max : max - rwd_width[2]}").to_a
    @input_wrapper_class = CssClass.new(options[:input_wrapper_class]).add("col-md-#{rwd_width[0]}", "col-sm-#{rwd_width[1]}", "col-xs-#{rwd_width[2]}").to_a
    wrapper.find(nil).defaults.merge!(class: @input_wrapper_class)
  end
end
