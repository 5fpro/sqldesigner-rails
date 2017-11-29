if defined?(Lograge)
  Rails.application.configure do
    config.lograge.enabled = true
    config.lograge.base_controller_class = 'ActionController::Base'

    config.lograge.custom_options = -> (event) do
      # return hash data only
      data = {}
      if event.payload[:exception]
        data.merge!(
          exception_class: event.payload[:exception][0],
          exception_message: event.payload[:exception][1].to_s.gsub("\n", '\n').gsub("\r", '\r')
        )
      end
      data
    end

    config.lograge.custom_payload do |controller|
      LoggerData.new(controller).to_h
    end

    config.lograge.before_format = -> (data, payload) do
      # refine any code u want
      data
    end
  end
end

# ref: https://github.com/roidrage/lograge/issues/146#issuecomment-255337408
class ActionDispatch::DebugExceptions
  def log_error(env, wrapper)
    BaseLogger.fatal(wrapper)
  end
end
