def staging?
  ENV['STAGING_MODE'].to_s == '1'
end
