class BaseStorage
  include ActiveModel::AttributeAssignment
  extend ActiveModel::Callbacks

  define_model_callbacks :save, :destroy

  attr_accessor :id

  class << self

    def all
      get_all_ids.map do |id|
        find(id)
      end.select(&:present?)
    end

    def find(id)
      data = JSON.parse(get_value(id).to_s)
      new(data.merge(id: id))
    rescue JSON::ParserError
      nil
    end

    def exists?(id)
      return false if id.blank?
      case @store_type
      when 'set' then redis.sismember(redis_key, id)
      when 'hash' then redis.hexists(redis_key, id)
      else
        redis.exists(redis_key(id))
      end
    end

    def clear
      case @store_type
      when 'set' then redis.del(redis_key)
      when 'hash' then redis.del(redis_key)
      else
        get_all_ids.each { |id| del(id) }
      end
    end

    private

    def default_expires(value)
      @ex = value
    end

    # target: 'set'|'hash'
    def store_type(target)
      @store_type = target.to_s
    end

    def redis
      @redis ||= Redis.current
    end

    def redis_key(id = nil)
      id = "-#{id}" if id.present?
      "storages-#{to_s.underscore}#{id}"
    end

    def set(id, data, ex)
      return false if id.blank?
      case @store_type
      when 'set' then redis.sadd(redis_key, id)
      when 'hash' then redis.hset(redis_key, id, data.to_json)
      else
        redis.set(redis_key(id), data.to_json, ex: ex || @ex)
      end
    end

    def del(id)
      return false if id.blank?
      case @store_type
      when 'set' then redis.srem(redis_key, id)
      when 'hash' then redis.hdel(redis_key, id)
      else
        redis.del(redis_key(id))
      end
    end

    def get_value(id)
      return false if id.blank?
      case @store_type
      when 'set' then redis.sismember(redis_key, id) ? {}.to_json : nil
      when 'hash' then redis.hget(redis_key, id)
      else
        redis.get(redis_key(id))
      end
    end

    def get_all_ids
      case @store_type
      when 'set' then redis.smembers(redis_key)
      when 'hash' then redis.hkeys(redis_key)
      else
        prefix = "#{redis_key}-"
        redis.keys.select { |key| key.index(prefix) == 0 }.map { |key| key.gsub(prefix, '') }
      end
    end

    def ttl(id)
      redis.ttl(redis_key(id))
    end
  end

  def initialize(attrs = {})
    attrs ||= {}
    assign_attributes(attrs)
  end

  def save(ex = nil)
    run_callbacks :save do
      generate_id! if id.blank?
      self.class.send(:set, id, attributes.except(:id), ex)
      id
    end
  end

  def destroy
    run_callbacks :destroy do
      self.class.send(:del, id)
    end
  end

  # TODO: assing new expires
  def update(attrs)
    assign_attributes(attrs.with_indifferent_access.except(:id))
    save
  end

  def attributes
    as_json.with_indifferent_access
  end

  def ttl
    self.class.send(:ttl, id)
  end

  private

  def generate_id!
    @id = SecureRandom.random_number.to_s[2..-1] until @id && !self.class.exists?(@id)
  end
end
