class ApplicationDetails < ActiveRecord::Base

  def self.sort_tracked_sites(client_id)
    tracked_site_id_query(client_id).map do |id|
      TrackedSite.find(id).url
    end
  end

  def self.tracked_site_id_query(client_id)
    Payload.group("tracked_site_id").where(client_id: client_id).order("count_tracked_site_id desc").count("tracked_site_id").keys
  end

  def self.get_event_data(client_id, tracked_site_id, events = [])
    #NEEDS TO BE WORKED

  end

  #THIS WORKS TOO: Payload.group("tracked_site_id").where(client_id: 1).order("average_responded_in desc").average("responded_in").keys
  def self.average_response(client_id, responses = {})
    tracked_site_id_query(client_id).each do |url_id|
      site = TrackedSite.find(url_id).url
      avg_response = Payload.where(tracked_site_id: url_id).average(:responded_in).to_i
      responses[site] = avg_response
    end
    responses
  end

  def self.resolutions(client_id)
    resolution_query(client_id).map do |resolution_id|
      Resolution.find(resolution_id).height_width
    end
  end

  def self.resolution_query(client_id)
    Payload.where(client_id: 1).pluck(:resolution_id).uniq
  end

  def self.user_agent_os(client_id)
    user_agent_breakdown(client_id).map do |user_agent|
      UserAgent.parse(user_agent).platform
    end.uniq
  end

  def self.user_agent_browser(client_id)
    user_agent_breakdown(client_id).map do |user_agent|
      UserAgent.parse(user_agent).browser
    end.uniq
  end

  def self.user_agent_breakdown(client_id)
    user_agent_query(client_id).map do |id|
      Agent.find(id).user_agent
    end
  end

  def self.user_agent_query(client_id)
    Payload.where(client_id: client_id).pluck(:agent_id).uniq
  end

end
