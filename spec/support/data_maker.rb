module DataMaker
  def data_for(key, attrs = {})
    send("data_for_#{key}").merge(attrs)
  end

  private

  def data_for_user
    { name: '5Fpro',
      email: 'user@5fpro.com', # TODO: sequence
      password: '12341234' }
  end

  def data_for_category
    { name: 'category haha' }
  end

  def data_for_creating_category
    data_for_category.merge(
      tag_list: 'a,b,c'
    )
  end

  def data_for_creating_user
    data_for_user.merge(
      admin: '0'
    )
  end
end
