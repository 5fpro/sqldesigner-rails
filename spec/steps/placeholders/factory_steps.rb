step '已有 :factory:' do |data, table|
  instance_variable_set("@#{data[:name]}", table.hashes.map { |h| create(*data[:factory], h) })
end

step '已有 :factory :number 筆' do |data, number|
  instance_variable_set("@#{data[:name]}", create_list(*data[:factory], number.to_i))
end

placeholder :factory do

  def get_factory(name)
    factory = FACTORY_NAME_MAP[name.to_sym] || name
    factory = [factory] unless factory.is_a?(Array)
    factory
  end

  match /[^\(\)]+/ do |name|
    factory = get_factory(name)
    name = factory.first.to_s
    {
      name: name.pluralize,
      factory: factory
    }
  end

  match /([^\(\)]+)\((.+)\)/ do |name, traits|
    factory = get_factory(name)
    name = factory.first.to_s
    {
      name: name.pluralize,
      factory: factory + traits.split(',')
    }
  end
end

FACTORY_NAME_MAP = {
  '已註冊使用者': :user,
  '分類': :category
}.freeze
