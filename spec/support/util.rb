module Util
  def omniauth_mock(provider)
    OmniAuth.config.mock_auth[provider]
  end

  def read_fixtures(filename)
    IO.read(Rails.root.join('spec').join('fixtures').join(filename))
  end
end
