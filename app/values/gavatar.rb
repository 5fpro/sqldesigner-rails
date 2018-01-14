require 'digest/md5'

class Gavatar
  def initialize(email)
    @email = email
  end

  def to_s(size = 100)
    "https://www.gravatar.com/avatar/#{encode}?s=#{size}"
  end

  private

  def encode
    Digest::MD5.hexdigest(@email.to_s.downcase)
  end
end
