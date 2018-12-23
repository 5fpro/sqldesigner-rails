Tyr.config.api_constraints = lambda do |req|
  req.subdomain.to_s.index('api')
end

Tyr.init!
