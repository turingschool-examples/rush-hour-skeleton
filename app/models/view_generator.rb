class ViewGenerator
  attr_reader :identifier,
              :client,
              :view,
              :data

  def initialize(identifier)
    @identifier = identifier
    @client     = Client.find_by(identifier: identifier)
    @data       = client_data
    @view       = render_client_view
  end

  def render_client_view
    if client_does_not_exist?
      :client_does_not_exist
    elsif client_does_not_have_requests?
      :client_has_no_requests
    else
      :show
    end
  end

  def client_does_not_exist?
    !Client.exists?(identifier: identifier)
  end

  def client_does_not_have_requests?
    !client.has_payload_requests?
  end

  def client_data
    {
      average_response_time: client.payload_requests.average_response_time.to_i,
      max_response_time:     client.payload_requests.max_response_time.to_i,
      min_response_time:     client.payload_requests.min_response_time.to_i,
      most_frequent_request_type: client.request_types.most_frequent,
      all_http_verbs_used: client.request_types.all_verbs_used,
      all_urls_from_most_to_least: client.urls.most_to_least_requested,
      web_browser_breakdown: client.user_agents.all_web_browsers,
      os_breakdown:          client.user_agents.all_operating_systems,
      screen_resolutions:    client.resolutions.all_resolutions
    }
  end

end
