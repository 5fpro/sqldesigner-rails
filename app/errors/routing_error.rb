class RoutingError < ApplicationError

  private

  def custom_initialize(request:)
    @request = request
  end

  def custom_to_h
    {
      request: {
        protocol: @request.protocol,
        full_path: @request.fullpath,
        method: @request.method,
        params: @request.params.to_h,
        headers: fetch_headers(@request)
      }
    }
  end

  def fetch_headers(request)
    {}.tap do |envs|
      request.headers.to_h.each do |key, value|
        envs[key] = value if key.downcase.starts_with?('http_')
      end
    end
  end

end
