class ApplicationDetails < ActiveRecord::Base

  def self.sort_tracked_sites
    tracked_site_id_list = Payload.group("tracked_site_id").order("count_tracked_site_id desc").count("tracked_site_id").keys
    tracked_site_id_list.map do |id|
      TrackedSite.find(id).url
    end
  end

end
