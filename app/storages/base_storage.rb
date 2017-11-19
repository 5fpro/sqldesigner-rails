class BaseStorage
  include ActiveModel::AttributeAssignment

  attr_accessor :id

  class << self

    def all
      prefix = redis_key('')
      redis.keys.select { |key| key.index(prefix) == 0 }.map do |key|
        find(key.gsub(prefix, ''))
      end.select(&:present?)
    end

    def find(id)
      data = JSON.parse(redis.get(redis_key(id)).to_s)
      new(data.merge(id: id))
    rescue JSON::ParserError
      nil
    end

    def exists?(id)
      return false if id.blank?
      redis.exists(redis_key(id))
    end

    private

    def default_expires(value)
      @ex = value
    end

    def ex
      @ex = 1.hour
    end

    def redis
      @redis ||= Redis.current
    end

    def redis_key(id)
      "storages-#{to_s.underscore}-#{id}"
    end

    def set(id, data, ex)
      return false if id.blank?
      redis.set(redis_key(id), data.to_json, ex: ex || @ex)
    end

    def del(id)
      return false if id.blank?
      redis.del(redis_key(id))
    end
  end

  def initialize(attrs = {})
    attrs ||= {}
    assign_attributes(attrs)
  end

  def save(ex = nil)
    generate_id! if id.blank?
    self.class.send(:set, id, attributes.except(:id), ex)
    id
  end

  def destroy
    self.class.send(:del, id)
  end

  # TODO: assing new expires
  def update(attrs)
    assign_attributes(attrs.with_indifferent_access.except(:id))
    save
  end

  def attributes
    as_json.with_indifferent_access
  end

  private

  def generate_id!
    @id = SecureRandom.random_number.to_s[2..-1] until @id && !self.class.exists?(@id)
  end
end
