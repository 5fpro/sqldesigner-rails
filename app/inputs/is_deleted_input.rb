class IsDeletedInput < BtnGroupInput
  # TODO: i18n

  private

  def collection
    [['Not Deleted', ''], ['Deleted', :only_deleted], ['All', :with_deleted]]
  end

  def label_text(*args)
    'Deleted'
  end
end
