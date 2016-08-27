require 'pry'
class IdentifierParser

  def initialize(source)
    @source = source
  end

  def parse
    return {} if @source.nil? 
    pairs = @source.split("&")
    payload = {}
    pairs.each do |pair|
      client_attributes = pair.split("=")
      payload[client_attributes.first.to_sym] = client_attributes.last
    end
    @source = replace_keys(payload)
  end

  def replace_keys(curl_payload)
    substitutions = {:rootUrl => :root_url}
    result = {}
    curl_payload.each_pair do |key, value|
      if substitutions.keys.include?(key)
        result[substitutions[key]] = value
      else
        result[key] = value
      end
    end
    result
  end
end
