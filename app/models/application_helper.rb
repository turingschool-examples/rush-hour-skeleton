module ApplicationHelper
  def self.status_message(status, message)
    [status, message]
  end

  def self.parse_json(json)
    JSON.parse(json, symbolize_names: true)
  end


end
