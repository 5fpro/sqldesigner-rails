MODEL_FINDER_MAP = {
  'User':     [:name, :email, :id],
  'Category': [:name, :id]
}.freeze

placeholder :model_finder do

  def find_instance_by_klass(klass, value)
    instance = nil
    MODEL_FINDER_MAP[klass.to_s.to_sym].each do |col|
      instance ||= klass.find_by(col => value)
      break if instance
    end
    instance || false
  end

  match /([A-Za-z][a-zA-Z0-9:]+)\((.+?)\)/ do |klass, value|
    klass = klass.camelize.constantize
    find_instance_by_klass(klass, value)
  end

  match /([^A-Za-z]+?.+)\((.+?)\)/ do |model_name, value|
    klass = find_model_name(model_name).to_s.camelize.constantize
    find_instance_by_klass(klass, value)
  end
end
