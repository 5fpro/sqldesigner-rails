I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
I18n.available_locales = [:en, :'zh-TW']
I18n.default_locale = :en
I18n.exception_handler = I18n::MissingTranslationData

if Rails.env.test? || Rails.env.development?

  module I18n
    class JustRaiseExceptionHandler < ExceptionHandler
      def call(exception, locale, key, options)
        if exception.is_a?(MissingTranslation)
          raise exception.to_exception
        else
          super
        end
      end
    end
  end

  I18n.exception_handler = I18n::JustRaiseExceptionHandler.new

end
