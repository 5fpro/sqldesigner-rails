# ref: https://github.com/plataformatec/simple_form/wiki/Adding-custom-input-components
class PicPreviewInput < SimpleForm::Inputs::FileInput
  def input(_wrapper_options = nil)
    # :version is a custom attribute from :input_html hash, so you can pick custom sizes
    version = input_html_options.delete(:version)
    out = ActiveSupport::SafeBuffer.new
    out << @builder.file_field(attribute_name, input_html_options)
    if object.send("#{attribute_name}?")
      remove_chk = @builder.check_box("remove_#{attribute_name}") # carrierwave: remove_xxx
      out << '<br />'.html_safe
      out << "<label>#{remove_chk} remove</label>".html_safe # TRANSLATION: I18n here
      out << '<br />'.html_safe
      out << template.image_tag(object.send(attribute_name).tap { |o| break o.send(version) if version }.send('url'))
    end
    out
  end
end
