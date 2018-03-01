class IsDeletedInput < BtnGroupInput

  private

  def collection
    { not_deleted: '', deleted: :only_deleted, all: :with_deleted }.map do |key, value|
      [I18n.t("simple_form.options.defaults.#{key}"), value]
    end
  end

  def label_text(*_args)
    I18n.t('simple_form.labels.defaults.is_deleted')
  end
end
