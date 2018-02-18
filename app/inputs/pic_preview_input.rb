# ref: https://github.com/plataformatec/simple_form/wiki/Adding-custom-input-components
class PicPreviewInput < SimpleForm::Inputs::FileInput
  def input(_wrapper_options = nil)
    # :version is a custom attribute from :input_html hash, so you can pick custom sizes
    version = input_html_options.delete(:version)
    out = ActiveSupport::SafeBuffer.new
    input_html_classes.push('form-control')
    out << @builder.file_field(attribute_name, input_html_options)
    if object.send("#{attribute_name}?")
      remove_chk = @builder.check_box("remove_#{attribute_name}", class: 'flat') # carrierwave: remove_xxx
      out << '<br />'.html_safe
      remove_text = I18n.t('simple_form.labels.defaults.remove')
      out << "<label>#{remove_chk} #{remove_text}</label>".html_safe
      out << '<br />'.html_safe
      img_path = object.send(attribute_name).tap { |o| break o.send(version) if version }.send('url')
      out << template.image_tag(img_path)
    end
    out
  end
end
