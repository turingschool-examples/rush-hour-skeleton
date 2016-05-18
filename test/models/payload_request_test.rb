require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers
  attr_reader :payload, :url, :referrer, :request_type, :event_name,
              :user_agent, :resolution, :ip

  def test_it_creates_a_payload_request_with_valid_attributes
    assert_equal "http://jumpstartlab.com/blog", payload.url.name
    assert_equal "http://jumpstartlab.com", payload.referrer.name
    assert_equal "GET", payload.request_type.verb
    assert_equal "socialLogin", payload.event_name.name
    assert_equal "Mozilla", payload.user_agent.browser
    assert_equal "Macintosh", payload.user_agent.platform
    assert_equal "1920", payload.resolution.width
    assert_equal "1280", payload.resolution.height
    assert_equal 37, payload.responded_in
    assert_equal "63.29.38.211", payload.ip.value
  end

  def test_it_finds_average_response_time
    payload2 = PayloadRequest.create({
      :url_id => url.id,
      :referrer_id => referrer.id,
      :request_type_id => request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => event_name.id,
      :user_agent_id => user_agent.id,
      :responded_in => 39,
      :parameters => [],
      :ip_id => ip.id,
      :resolution_id => resolution.id
      })
    assert_equal 38, PayloadRequest.average_response_time
  end

  def test_it_finds_max_response_time
    payload2 = PayloadRequest.create({
      :url_id => url.id,
      :referrer_id => referrer.id,
      :request_type_id => request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => event_name.id,
      :user_agent_id => user_agent.id,
      :responded_in => 39,
      :parameters => [],
      :ip_id => ip.id,
      :resolution_id => resolution.id
      })
    assert_equal 39, PayloadRequest.max_response_time
  end

  def test_it_finds_min_response_time
    payload2 = PayloadRequest.create({
      :url_id => url.id,
      :referrer_id => referrer.id,
      :request_type_id => request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => event_name.id,
      :user_agent_id => user_agent.id,
      :responded_in => 39,
      :parameters => [],
      :ip_id => ip.id,
      :resolution_id => resolution.id
      })
    assert_equal 37, PayloadRequest.min_response_time
  end

  def test_it_finds_most_frequent_request_type
    payload2 = PayloadRequest.create({
      :url_id => url.id,
      :referrer_id => referrer.id,
      :request_type_id => request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => event_name.id,
      :user_agent_id => user_agent.id,
      :responded_in => 39,
      :parameters => [],
      :ip_id => ip.id,
      :resolution_id => resolution.id
      })
    assert_equal 2, PayloadRequest.counts_request_type_max
    assert_equal ["GET"], PayloadRequest.most_frequent_request_type
  end

  def test_it_handles_most_frequent_request_type_when_there_is_a_tie
    request_type2 = RequestType.create({:verb => "POST"})
    payload2 = PayloadRequest.create({
      :url_id => url.id,
      :referrer_id => referrer.id,
      :request_type_id => request_type2.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => event_name.id,
      :user_agent_id => user_agent.id,
      :responded_in => 39,
      :parameters => [],
      :ip_id => ip.id,
      :resolution_id => resolution.id
      })
    assert_equal ["POST", "GET"], PayloadRequest.most_frequent_request_type
  end

  def test_urls_get_returned_in_order_by_count_for_one
    assert_equal ["http://jumpstartlab.com/blog"], PayloadRequest.order_urls_by_count
  end

  def test_urls_get_returned_in_order_by_count_for_multiple
    url2 = Url.create({:name => "http://jumpstartlab.com/shop"})
    payload2 = PayloadRequest.create({
      :url_id => url2.id,
      :referrer_id => referrer.id,
      :request_type_id => request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => event_name.id,
      :user_agent_id => user_agent.id,
      :responded_in => 39,
      :parameters => [],
      :ip_id => ip.id,
      :resolution_id => resolution.id
      })
    assert_equal ["http://jumpstartlab.com/shop", "http://jumpstartlab.com/blog"], PayloadRequest.order_urls_by_count
  end

end
