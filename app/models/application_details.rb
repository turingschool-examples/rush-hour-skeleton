class ApplicationDetails < ActiveRecord::Base

  def self.sort_tracked_urls
    Payload.order(tracked_site_id: :desc)
  end

end
