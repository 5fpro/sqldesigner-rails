class AdminFormBuilder < SimpleForm::FormBuilder

  # admin_form_for(...., rwd: [11, 11, 12])
  def initialize(*)
    super
    handle_rwd_with!
  end

  def label(*args)
    super(*merge_args_options(args, class: to_classes(args.extract_options![:class], @label_wrapper_class).join(' ')))
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

  def to_classes(class_name, append = nil)
    class_name = class_name.join(' ') if class_name.is_a?(Array)
    append = append.join(' ') if append.is_a?(Array)
    class_name = "#{class_name} #{append}"
    class_name.split(' ').map { |s| s.gsub(' ', '') }.select(&:present?).uniq
  end

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
    @label_wrapper_class = to_classes(options[:label_wrapper_class], "col-md-#{max - rwd_width[0]} col-sm-#{max - rwd_width[1]} col-xs-#{rwd_width[2] == max ? max : max - rwd_width[2]}")
    @input_wrapper_class = to_classes(options[:input_wrapper_class], "col-md-#{rwd_width[0]} col-sm-#{rwd_width[1]} col-xs-#{rwd_width[2]}")
    wrapper.find(nil).defaults.merge!(class: @input_wrapper_class)
  end
end
