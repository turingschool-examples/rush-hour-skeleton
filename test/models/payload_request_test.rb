require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_that_you_can_create_payload_request
    payload = PayloadRequest.create(url_id:2,
    requested_at:"2013-02-16 21:38:28 -0700",
    responded_in:37,
    referred_by:2,
    request_type:2,
    user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    resolution_id:4,
    ip:2)
    assert_equal 4, payload.resolution_id
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", payload.user_agent
  end

  def test_find_average
    PayloadRequest.create(responded_in:10)
    PayloadRequest.create(responded_in:220)
    PayloadRequest.create(responded_in:100)

    assert_equal 110, PayloadRequest.average(:responded_in)
  end

  def test_max_response_time
    PayloadRequest.create(responded_in:10)
    PayloadRequest.create(responded_in:220)
    PayloadRequest.create(responded_in:100)

    assert_equal 220, PayloadRequest.maximum(:responded_in)
  end

  def test_min_response_time
    PayloadRequest.create(responded_in:10)
    PayloadRequest.create(responded_in:220)
    PayloadRequest.create(responded_in:100)
    assert_equal 10, PayloadRequest.minimum(:responded_in)
  end
  
end
