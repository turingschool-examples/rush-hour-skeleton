require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_payload_request_with_valid_attributes
    payload = create_payload(1)
    payload = PayloadRequest.find(1)

    assert_equal 1, payload.id
    assert_equal 1, payload.resolution_id
    assert_equal 1, payload.referred_by_id
    assert_equal "http://jumpstartlab.com/blog0", payload.url.address
    assert_equal "http://jumpstartlab.com0", payload.referrer.address
    assert_equal "GET 0", payload.request_type.verb
    assert_equal "Chrome0", payload.software_agent.browser
    assert_equal "OSX 10.11.50", payload.software_agent.os
    assert_equal "19200", payload.resolution.width
    assert_equal "12800", payload.resolution.height
    assert_equal 0, payload.responded_in
    assert_equal "63.29.38.2110", payload.ip.address
end

# def test_find_average
#   PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:50,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
#   PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:150,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
#   PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:100,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
#
#   assert_equal 100, PayloadRequest.average(:responded_in)
# end
#
# def test_max_response_time
#   PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:10,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
#   PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:20,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
#   PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:30,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
#   assert_equal 30, PayloadRequest.maximum(:responded_in)
# end
#
# def test_min_response_time
#   PayloadRequest.create(responded_in:10)
#   PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:30,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
#   PayloadRequest.create(url_id:1, requested_at: Time.now,responded_in:40,referred_by_id:1,request_type_id:1,software_agent_id:1,ip_id:1,resolution_id:1)
#   assert_equal 30, PayloadRequest.minimum(:responded_in)
# end
end
