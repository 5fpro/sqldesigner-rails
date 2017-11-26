step '已有 :factory:' do |data, table|
  instance_variable_set("@#{data[:name]}", table.hashes.map { |h| create(*data[:factory], h) })
end

step '已有 :factory :number 筆' do |data, number|
  instance_variable_set("@#{data[:name]}", create_list(*data[:factory], number.to_i))
end

placeholder :factory do

  def get_factory_name(name)
    (FACTORY_NAME_MAP[name.to_sym] || name).to_s
  end

  match /[^\(\)]+/ do |name|
    name = get_factory_name(name)
    {
      name: name.pluralize,
      factory: [name.singularize]
    }
  end

  match /([^\(\)]+)\((.+)\)/ do |name, traits|
    name = get_factory_name(name)
    {
      name: name.pluralize,
      factory: [name.singularize] + traits.split(',')
    }
  end
end

FACTORY_NAME_MAP = {
  '已註冊使用者': :user
}.freeze
