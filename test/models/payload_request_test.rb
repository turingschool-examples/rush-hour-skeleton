require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_that_you_can_create_payload_request
    payload = create_payload
    assert_equal 1, payload.resolution_id
    assert_equal 1, payload.referred_by_id
  end

  def test_find_average
    PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:50,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
    PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:150,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
    PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:100,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)

    assert_equal 100, PayloadRequest.average(:responded_in)
  end

  def test_max_response_time
    PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:10,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
    PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:20,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
    PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:30,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
    assert_equal 30, PayloadRequest.maximum(:responded_in)
  end

  def test_min_response_time
    PayloadRequest.create(responded_in:10)
    PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:30,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
    PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:40,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
    assert_equal 30, PayloadRequest.minimum(:responded_in)
  end
end
