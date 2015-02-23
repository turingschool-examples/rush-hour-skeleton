class Url < ActiveRecord::Base
  has_many :payloads

  def self.longest_response_time(webpage)
    Url.find_by(address: webpage).payloads.maximum(:responded_in)
  end

  def self.shortest_response_time(webpage)
    Url.find_by(address: webpage).payloads.minimum(:responded_in)
  end

  def self.average_response_time(webpage)
    Url.find_by(address: webpage).payloads.average(:responded_in)
  end

  def self.make_requests_readable(requests)
    if requests.uniq.length > 1
       requests.join(" / ")
    else
       requests.uniq
    end
  end

  def self.request_types(webpage)
    payloads = Url.find_by(address: webpage).payloads

    requests = payloads.map do |payload|
      Request.find(payload.request_id).request_type
    end

    make_requests_readable(requests)
  end
end
