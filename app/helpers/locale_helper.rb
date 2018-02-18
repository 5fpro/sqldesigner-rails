module LocaleHelper
  def tv(key_path, opts = {})
    key_paths = [
      :".view.#{key_path}",
      :".#{key_path}",
      :"activerecord.attributes.#{key_path}",
      :"views.defaults.#{key_path}"
    ]
    opts[:model] = translate_model_name(opts[:model]) if opts[:model].present?
    t(key_paths.shift, opts.merge(default: key_paths))
  end

  private

  def translate_model_name(model)
    return '' if model.blank?
    return model.class.model_name.human if model.is_a?(ApplicationRecord)
    model.try(:model_name).try(:human)
  end
end
