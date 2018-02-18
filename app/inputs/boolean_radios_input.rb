class BooleanRadiosInput < BtnGroupInput

  private

  def collection
    { all: '', yes: true, no: false }.map do |key, value|
      [I18n.t("simple_form.options.defaults.#{key}"), value]
    end
  end

end
