require 'singleton'

class BaseSettings

  attr_reader :settings

  include Singleton

  class << self
    private

    def settings
      instance.settings
    end
  end

  def initialize
    if self.class.to_s != 'base_settings'
      @settings = Rails.application.config_for(self.class.to_s.underscore).deep_symbolize_keys
    end
  end

end
