require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_payload_has_the_attributes
    payload_request = PayloadRequest.new

    assert_respond_to payload_request, :requested_at
    assert_respond_to payload_request, :responded_in
    assert_respond_to payload_request, :resolution_id
    assert_respond_to payload_request, :referrer_id
    assert_respond_to payload_request, :url_request_id
    assert_respond_to payload_request, :user_agent_id
    assert_respond_to payload_request, :event_name
  end

  def test_attributes_must_be_present_when_saving
    payload_request = PayloadRequest.new

    payload_request.save

    assert_equal 0, PayloadRequest.all.count
  end

  def test_payload_request_has_attribute_values
    payload_request = PayloadRequest.new(responded_in: payload[:respondedIn],
                           requested_at: payload[:requestedAt],
                           event_name:   payload[:eventName])

    assert_equal "2013-02-16 21:38:28 -0700", payload_request.requested_at
    assert_equal 37, payload_request.responded_in
    assert_equal "socialLogin", payload_request.event_name
  end

  def test_creates_relationships
    referrer = Referrer.create(referred_by: payload[:referredBy])
    url_request = UrlRequest.create(url: "something", parameters: "array")
    user_agent = UserAgent.create(browser: "dkfjsdfj", os: "kdjfj")
    resolution = Resolution.create(resolution_width: "sjdf", resolution_height: "djsff")
    ip_address = IpAddress.create(ip: "ddkfjd")
    verb = Verb.create(request_type: "GET")
    client = Client.create(identifier: "identifier", root_url: "root_url")
    test_payload = PayloadRequest.create(requested_at: payload[:requestedAt],
                                    responded_in: payload[:respondedIn])

    test_payload.update(referrer_id: referrer.id)
    test_payload.update(url_request_id: url_request.id)
    test_payload.update(user_agent_id: user_agent.id)
    test_payload.update(resolution_id: resolution.id)
    test_payload.update(ip_address_id: ip_address.id)
    test_payload.update(verb_id: verb.id)
    test_payload.update(client_id: client.id)

    assert_equal referrer.id, test_payload.referrer.id
    assert_equal url_request.id, test_payload.url_request.id
    assert_equal user_agent.id, test_payload.user_agent.id
    assert_equal resolution.id, test_payload.resolution.id
    assert_equal ip_address.id, test_payload.ip_address.id
    assert_equal verb.id, test_payload.verb.id
    assert_equal client.id, test_payload.client.id
  end

  def test_calculates_avg_response_time
    create_payload_requests_with_associations(responded_in: 50)
    create_payload_requests_with_associations(responded_in: 30)

    assert_equal 40, PayloadRequest.average_response_time
  end

  def test_calculates_max_response_time
    create_payload_requests_with_associations(responded_in: 50)
    create_payload_requests_with_associations(responded_in: 30)

    assert_equal 50, PayloadRequest.max_response_time
  end

  def test_calculates_min_response_time
    create_payload_requests_with_associations(responded_in: 50)
    create_payload_requests_with_associations(responded_in: 30)

    assert_equal 30, PayloadRequest.min_response_time
  end

  def test_most_frequent_request_type
    create_payload_requests_with_associations(request_type: "POST")
    create_payload_requests_with_associations(requested_at: rand_time)
    create_payload_requests_with_associations(requested_at: rand_time)

    assert_equal "GET", PayloadRequest.most_frequent_request_type
  end

  def test_list_of_urls_by_frequency_desc
    create_payload_requests_with_associations(url: "http://google.com")
    create_payload_requests_with_associations(requested_at: rand_time)
    create_payload_requests_with_associations(requested_at: rand_time)

    assert_equal ["http://jumpstartlab.com/blog", "http://google.com"], PayloadRequest.most_frequent_urls
  end

  def test_events_listed_in_descending_order
    create_payload_requests_with_associations(event_name: 'Facebook')
    create_payload_requests_with_associations(requested_at: rand_time, event_name: 'Facebook')
    create_payload_requests_with_associations(event_name: 'Google')

    assert_equal ['Facebook', 'Google'], PayloadRequest.event_name_breakdown
  end
 end
