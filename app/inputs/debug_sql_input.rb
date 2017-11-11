class DebugSqlInput < SimpleForm::Inputs::StringInput

  def input(*args)
    return '' if Rails.env.production?
    super(*args)
  end

  private

  def input_html_options(*args)
    (super(*args) || {}).merge(name: '', value: object.result.to_sql)
  end

  def attribute_name
    :created_at_eq
  end

  def label_text(*_args)
    'Debug SQL'
  end
end
