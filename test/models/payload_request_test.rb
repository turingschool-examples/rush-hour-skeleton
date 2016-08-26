require_relative '../test_helper'
require './app/models/payload_request'

class PayloadRequestTest < ModelTest
  def test_it_finds_an_active_record_object
    PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            user_agent_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: 6
                            })
    payload_request = PayloadRequest.first

    assert_instance_of PayloadRequest, payload_request
    assert_kind_of ActiveRecord::Base, payload_request
  end

  def test_it_validates_payloads_for_completeness
    payload_happy = PayloadRequest.new({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            user_agent_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: 6
                            })
    assert payload_happy.save

    payload_sad = PayloadRequest.new({
                            responded_in: 3,
                            resolution_id: 1,
                            user_agent_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: 6
                            })

    refute payload_sad.save
  end
  
  
  
  
end
