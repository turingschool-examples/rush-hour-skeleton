class ApplicationDetails < ActiveRecord::Base

  def self.sort_tracked_urls
    tracked_site_ids = Payload.group("tracked_site_id").order("count_tracked_site_id desc").count("tracked_site_id").keys
    
  end

end
