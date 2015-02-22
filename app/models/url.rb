class Url < ActiveRecord::Base
  has_many :payloads

  def self.longest_response_time(full_url)
    #find all payloads for URL, then find the maximum responded_in
    url = Url.where(address: full_url)
    Payload.where(url_id: url.id).maximum(:responded_in)
  end

  # def relative_path
  #   Url.identifier
  #   root_url = "http://tutorials.jumpstartlab.com"
  #   full_url = "http://tutorials.jumpstartlab.com/projects/traffic_spy.html"
  #   path = full_url.slice(root_url.length, full_url.length)
  #
  # end
end
