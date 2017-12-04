module AdminRadiosInputConcern

  def label(wrapper_options = nil)
    wrapper_options ||= {}
    wrapper_options[:class] = CssClass.new(wrapper_options[:class]).add(@builder.label_wrapper_class).to_a
    super(wrapper_options)
  end

end
