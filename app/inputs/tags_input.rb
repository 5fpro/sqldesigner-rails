class TagsInput < SimpleForm::Inputs::CollectionSelectInput

  private

  def input_options
    super.merge(include_blank: false)
  end

  def input_html_options(*args)
    (super(*args) || {}).merge(class: 'js-select2-tags', multiple: 'multiple')
  end

  def collection
    @collection ||= Tag.all.map { |tag| [tag.name, tag.name] }
  end

  def multiple?
    true
  end

  def skip_include_blank?
    false
  end
end
