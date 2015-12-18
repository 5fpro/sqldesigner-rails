module Util
  def omniauth_mock(provider)
    OmniAuth.config.mock_auth[provider]
  end
end
