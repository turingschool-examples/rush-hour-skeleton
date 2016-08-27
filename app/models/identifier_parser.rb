class IdentifierParser

  def initialize(source)
    @source = source
  end

  def parse
    @source = replace_keys(@source)
  end

  def replace_keys(curl_payload)
    substitutions = {:rootUrl => :root_url}
    result = {}
    curl_payload.each_pair do |key, value|
      if substitutions.keys.include?(key.to_sym)
        result[substitutions[key.to_sym]] = value
      else
        result[key.to_sym] = value
      end
    end
    result
  end
end
