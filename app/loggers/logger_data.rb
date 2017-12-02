class LoggerData

  # 順序有差，先符合先 call
  CLASS_MAP = {
    ::ActionController::Base           => 'controller',
    ::Rack::Request                    => 'rack_request',
    ::ActionDispatch::ExceptionWrapper => 'exception_wrapper'
  }.freeze

  def initialize(obj)
    @obj = obj
  end

  def to_h
    CLASS_MAP.each do |klass, method_name|
      return send(method_name) if @obj.is_a?(klass)
    end
    {}
  end

  private

  def controller
    data = {
      host: @obj.request.host,
      user_id: @obj.try(:current_user).try(:id),
      fullpath: @obj.request.original_fullpath,
      ip: @obj.request.remote_ip,
      query_params: @obj.request.query_parameters.to_json,
      raw_body: file_upload?(@obj) ? '[file upload]' : escape_text(@obj.request.raw_post),
      controller_params: @obj.params.permit!.to_h.except('controller', 'action').to_s
    }
    if @obj.response.status.to_s[0] == '3'
      data[:redirect_to] = @obj.response.location
    end
    data
  end

  def file_upload?(controller)
    controller.request.params.values.select { |v| v.is_a?(ActionDispatch::Http::UploadedFile) }.present?
  end

  def rack_request
    {
      host: @obj.host,
      fullpath: @obj.fullpath,
      ip: @obj.ip,
      method: @obj.request_method,
      query_params: Rack::Utils.parse_nested_query(@obj.env['QUERY_STRING']).to_json,
      raw_body: escape_text(@obj.body.try(:string) || @obj.body.try(:read))
    }
  end

  def escape_text(text)
    text.to_s.force_encoding('UTF-8').gsub("\n", '\n').gsub("\r", '\r')
  end

  def exception_wrapper
    env = @obj.env
    exception = @obj.exception
    {
      method: env['REQUEST_METHOD'],
      path: env['REQUEST_PATH'],
      host: env['SERVER_NAME'],
      status: @obj.status_code,
      fullpath: env['ORIGINAL_FULLPATH'],
      ip: env['REMOTE_ADDR'],
      query_params: Rack::Utils.parse_nested_query(env['QUERY_STRING']).to_json,
      raw_body: escape_text(env['rack.input'].read)
    }.merge(parse_exception(exception, backtrace: need_backtrace?(exception)))
  end

  def need_backtrace?(exception)
    ![ActionController::RoutingError].include?(exception.class)
  end

  def parse_exception(exception, backtrace: false)
    h = {
      exception_class: exception.class.to_s,
      exception_message: exception.message
    }
    h[:exception_backtrace] = escape_text(exception.backtrace.to_json) if backtrace
    h
  end
end
