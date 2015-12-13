module TrafficSpy
  class Payload < ActiveRecord::Base
    belongs_to :application
    belongs_to :relative_path
    belongs_to :request_type
    belongs_to :resolution
    belongs_to :operating_system
    belongs_to :browser
    belongs_to :event
    validates_uniqueness_of :application_id, scope: [:requested_at,
                                                     :responded_in, :referred_by,
                                                     :ip_address,
                                                     :relative_path_id, :request_type_id,
                                                     :resolution_id, :operating_system_id,
                                                     :browser_id, :event_id]
  end
end
