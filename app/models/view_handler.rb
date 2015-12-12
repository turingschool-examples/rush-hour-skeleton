module ViewHandler

  def self.assign_application_details_erb_path(client)
    return :application_details if client && !client.payloads.empty?
    return :error
  end

  def self.assign_application_details_error_message(client)
    return "No payload data has been received for this source." if client && client.payloads.empty?
    return "The identifier does not exist." if !client
  end

  def self.assign_url_details_erb_path(path)
    return :url_details if Payload.unique_paths.include?(path)
    return :error
  end

  def self.assign_url_details_error_message(path)
    return "That URL has not been requested." if !Payload.unique_paths.include?(path)
  end

  def self.assign_events_index_erb_path
    return :events_index if Payload.exists?(:event_name)
    return :error
  end

  def self.assign_events_index_error_message
    return "No events have been defined." if !Payload.exists?(:event_name)
  end

end
