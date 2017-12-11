json.error do
  data = @error.to_h
  json.class_name data[:original].try(:[], :class_name) || data[:class_name]
  json.message @error.original_message
  json.backtrace Rails.env.production? ? nil : @error.original_backtrace
  json.context data[:context]
  if data[:original]
    json.original data[:original].merge(Rails.env.production? ? { backtrace: nil } : {})
  end
end
