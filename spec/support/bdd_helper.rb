module BddHelper
  def to_request_params(value)
    return value.hashes if value.respond_to?(:hashes)
    value = parse_bdd_body(value) if value.is_a?(String)
    return value.map(:with_indifferent_access) if value.is_a?(Array) && value[0].is_a?(Hash)
    return [value] if value.is_a?(Hash)
    [{}]
  end

  def parse_bdd_body(body)
    return {} unless body
    YAML.load(body) rescue JSON.parse(body)
  end
end
