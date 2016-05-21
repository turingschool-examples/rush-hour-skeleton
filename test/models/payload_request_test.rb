require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_payload_request_with_valid_attributes
    create_payloads(1)
    payload = PayloadRequest.find(1)

    assert_equal "http://jumpstartlab.com/blog0", payload.url.name
    assert_equal "http://jumpstartlab.com0", payload.referrer.name
    assert_equal "GET 0", payload.request_type.verb
    assert_equal "socialLogin 0", payload.event_name.name
    assert_equal "Mozilla 0", payload.user_agent.browser
    assert_equal "Macintosh 0", payload.user_agent.platform
    assert_equal "1920 0", payload.resolution.width
    assert_equal "1280 0", payload.resolution.height
    assert_equal 0, payload.responded_in
    assert_equal "63.29.38.210", payload.ip.value
  end

  def test_it_finds_average_response_time
    create_payloads(3)

    assert_equal 1, PayloadRequest.average_response_time
  end

  def test_it_finds_max_response_time
    create_payloads(3)

    assert_equal 2, PayloadRequest.max_response_time
  end

  def test_it_finds_min_response_time
    create_payloads(3)

    assert_equal 0, PayloadRequest.min_response_time
  end

  # def test_it_finds_most_frequent_request_type
  #   PayloadRequest.create({
  #     :url_id => url.id,
  #     :referrer_id => referrer.id,
  #     :request_type_id => request_type.id,
  #     :requested_at => "2013-02-16 21:38:28 -0700",
  #     :event_name_id => event_name.id,
  #     :user_agent_id => user_agent.id,
  #     :responded_in => 39,
  #     :parameters => [],
  #     :ip_id => ip.id,
  #     :resolution_id => resolution.id,
  #     :client_id => client.id
  #     })
  #   assert_equal 2, PayloadRequest.counts_request_type_max
  #   assert_equal ["GET"], PayloadRequest.most_frequent_request_type
  # end
  #
  # def test_it_handles_most_frequent_request_type_when_there_is_a_tie
  #   request_type2 = RequestType.create({:verb => "POST"})
  #   PayloadRequest.create({
  #     :url_id => url.id,
  #     :referrer_id => referrer.id,
  #     :request_type_id => request_type2.id,
  #     :requested_at => "2013-02-16 21:38:28 -0700",
  #     :event_name_id => event_name.id,
  #     :user_agent_id => user_agent.id,
  #     :responded_in => 39,
  #     :parameters => [],
  #     :ip_id => ip.id,
  #     :resolution_id => resolution.id,
  #     :client_id => client.id
  #     })
  #   assert PayloadRequest.most_frequent_request_type.include?("POST")
  #   assert PayloadRequest.most_frequent_request_type.include?("GET")
  # end
  #
  # def test_urls_get_returned_in_order_by_count_for_one
  #   assert_equal ["http://jumpstartlab.com/blog"], PayloadRequest.order_urls_by_count
  # end
  #
  # def test_urls_get_returned_in_order_by_count_for_multiple
  #   url2 = Url.create({:name => "http://jumpstartlab.com/shop"})
  #   PayloadRequest.create({
  #     :url_id => url2.id,
  #     :referrer_id => referrer.id,
  #     :request_type_id => request_type.id,
  #     :requested_at => "2013-02-16 21:38:28 -0700",
  #     :event_name_id => event_name.id,
  #     :user_agent_id => user_agent.id,
  #     :responded_in => 39,
  #     :parameters => [],
  #     :ip_id => ip.id,
  #     :resolution_id => resolution.id,
  #     :client_id => client.id
  #     })
  #   assert PayloadRequest.order_urls_by_count.include?("http://jumpstartlab.com/shop")
  #   assert PayloadRequest.order_urls_by_count.include?("http://jumpstartlab.com/blog")
  # end

end
