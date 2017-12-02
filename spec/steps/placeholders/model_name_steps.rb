MODEL_NAME_MAP = {
  '使用者': :user,
  '分類': :category
}.freeze

def find_model_name(name)
  MODEL_NAME_MAP[name.to_sym] || name
end

placeholder :model_name do
  match /.+/ do |name|
    find_model_name(name)
  end
end
