class BaseSetting < Settingslogic

  class << self

    def inherited(subklass)
      subklass.send(:config_name, subklass.to_s.underscore)
    end

    private

    def config_name(file_name)
      file_path = Rails.root.join('config', "#{file_name}.yml")
      if File.exist?(file_path)
        source(file_path)
        namespace(Rails.env)
      end
    end
  end
end
