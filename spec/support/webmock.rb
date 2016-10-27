module Webmock
  def webmock_all!
    # example
    stub_request(:get, 'https://google.com/api.json')
      .to_return(headers: { 'Content-Type' => 'application/json' }, body: '{ "ok": true }')

    # slack
    stub_request(:post, /https:\/\/hooks\.slack\.com\/services\//)
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type' => 'application/x-www-form-urlencoded', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: '', headers: { 'Content-Type' => 'application/json' })
  end
end
