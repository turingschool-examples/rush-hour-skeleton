module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :application
    validates_uniqueness_of :application_id, scope: [:relative_path, :requested_at,
                                                     :responded_in, :referred_by,
                                                     :request_type, :event,
                                                     :operating_system, :browser,
                                                     :resolution, :ip_address]
  end
end
