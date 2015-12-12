class ErrorHandler

  attr_reader :client, :erb_path, :error_message

  def initialize(client)
    @client = client
    @erb_path = assign_erb_path
    @error_message = assign_error_message
  end

  def assign_erb_path
    return :application_details if client && !client.payloads.empty?
    return :error
  end

  def assign_error_message
    return "No payload data has been received for this source." if @client && @client.payloads.empty?
    return "The identifier does not exist." if !client
  end

end
