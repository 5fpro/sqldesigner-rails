class BooleanRadiosInput < BtnGroupInput
  # TODO: i18n

  private

  def collection
    [['All', ''], ['Yes', true], ['No', false]]
  end

end
