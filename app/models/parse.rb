require 'json'

class ParsePayload

  def self.parse(params)
    JSON.parse(params['payload'])
  end

end
