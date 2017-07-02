class BaseSetting < Settingslogic

  class << self

    def inherited(subklass)
      subklass.source(Rails.root.join('config', "#{subklass.to_s.underscore}.yml"))
      subklass.namespace(Rails.env)
    end

  end
end
