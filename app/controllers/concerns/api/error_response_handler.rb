module Api
  module ErrorResponseHandler
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError do |e|
        respond_error_by_exception(:internal_error, e, status: 500)
      end

      rescue_from Errors::Exception do |e|
        messages = JSON.parse(e.info[:messages_json])
        messages << e.message if messages.empty?
        debug = {
          bt: e.backtrace,
          info: e.info
        }
        respond_error e.name, status: e.status, messages: messages, debug: debug
      end

      rescue_from ActionController::ParameterMissing do |e|
        respond_error_by_exception(:parameter_missing, e)
      end
    end

    def respond_404
      respond_error(:page_not_found, messages: "#{request.fullpath} is not found", status: 404)
    end

    protected

    def respond_error_by_exception(name, e, status: 400)
      respond_error(name, status: status, messages: e.message, debug: e.backtrace)
    end

    def respond_error(name, messages: nil, status: 400, debug: nil)
      render json: gen_error_obj(name, messages, debug), status: status
    end

    def gen_error_obj(name, messages, debug)
      messages ||= []
      messages = [messages] unless messages.is_a?(Array)
      error_obj = {
        error: true,
        name: name,
        messages: messages
      }
      error_obj[:debug] = debug unless Rails.env.production?
      error_obj
    end
  end
end
