MODEL_FINDER_MAP = {
  'User' => [:name, :email, :id]
}.freeze

placeholder :model_finder do
  match /([A-Z][a-zA-Z0-9:]+)\((.+?)\)/ do |klass, value|
    klass = klass.constantize
    instance = nil
    MODEL_FINDER_MAP[klass.to_s].each do |col|
      instance ||= klass.find_by(col => value)
      break if instance
    end
    instance || false
  end
end
