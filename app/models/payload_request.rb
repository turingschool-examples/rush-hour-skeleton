class PayloadRequest < ActiveRecord::Base

  validates_presence_of :url_id,
                        :requested_at,
                        :responded_in,
                        :referrer_url_id,
                        :request_type_id,
                        :parameters,
                        :event_name_id,
                        :user_agent_id,
                        :resolution_id,
                        :ip_id

  def self.average_response_time
    average(:responded_in).to_i
  end

end
