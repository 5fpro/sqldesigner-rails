class CacheStorage
  attr_accessor :key

  def initialize(key, value, expires_in: 1.day, tags: nil)
    @key = key
    @value = value
    @expires_in = expires_in
    @tags = init_tags(tags)
  end

  def save
    Rails.cache.write(@key, @value, expires_in: @expires_in)
    create_to_tags
  end

  def destroy
    Rails.cache.delete(@key)
  end

  class << self
    def clear_by_tags(*tags)
      tags.map(&:to_s).select(&:present?).each do |tag|
        instances = find_by(tag: tag)
        instances.each do |instance|
          instance.destroy
          delete_from_tag(tag, instance.key)
        end
      end
    end

    def find_by(tag:)
      send(:find_by_tag, tag)
    end

    def find(key)
      value = fetch(key)
      return if value.nil?
      new(key, value)
    end

    def fetch(key)
      Rails.cache.fetch(key)
    end

    def exist?(key)
      Rails.cache.exist?(key)
    end

    def fetch_or_cache(key, expires_in: 1.day, tags: nil, json: true)
      if exist?(key)
        value = fetch(key)
        value = JSON.parse(value).with_indifferent_access if json
      else
        value = yield
        new(key, json ? value.to_json : value, expires_in: expires_in, tags: tags).save
      end
      value
    end

    private

    def find_by_tag(tag)
      return [] if tag.to_s.blank?
      instances = store(tag).members.map do |key|
        instance = find(key)
        delete_from_tag(tag, key) unless instance
        instance
      end
      instances.select(&:present?)
    end

    def add_to_tag(tag, key)
      store(tag) << key
    end

    def delete_from_tag(tag, key)
      store(tag).delete(key)
    end

    def store(tag)
      Redis::Set.new("#{self.class.to_s.underscore}-#{tag}")
    end
  end

  private

  def create_to_tags
    (@tags || []).each { |tag| self.class.send(:add_to_tag, tag, @key) }
  end

  def init_tags(tags)
    tags.present? && tags.is_a?(Array) ? tags : [tags].select(&:present?)
  end
end
