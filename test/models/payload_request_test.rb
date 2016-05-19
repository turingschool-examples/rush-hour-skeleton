require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test

  include TestHelpers

  def test_payload_without_info_is_not_valid
    refute PayloadRequest.create(nil).valid?
  end

  def test_it_validates_payload_request_with_values
    assert PayloadRequest.create({url_id: 2, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1}).valid?
  end

  def test_it_averages_response_times
    PayloadRequest.create({url_id: 2, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    PayloadRequest.create({url_id: 1, requested_at: "2013-02-17 21:38:28 -0700", responded_in: 10, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 2, ip_id: 2})

    assert_equal 15, PayloadRequest.average_response_time
  end

  def test_it_finds_max_response_time
    PayloadRequest.create({url_id: 2, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    PayloadRequest.create({url_id: 1, requested_at: "2013-02-17 21:38:28 -0700", responded_in: 10, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 2, ip_id: 2})

    assert_equal 20, PayloadRequest.max_response_time
  end

  def test_it_finds_min_response_time
    PayloadRequest.create({url_id: 2, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
    PayloadRequest.create({url_id: 1, requested_at: "2013-02-17 21:38:28 -0700", responded_in: 10, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 2, ip_id: 2})

    assert_equal 10, PayloadRequest.min_response_time
  end

end
