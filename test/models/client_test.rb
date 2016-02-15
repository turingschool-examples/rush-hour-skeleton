require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_has_an_identifier_attribute
    client = Client.new

    assert_respond_to client, :identifier
  end

  def test_it_has_a_root_url_attribute
    client = Client.new

    assert_respond_to client, :root_url
  end

  def test_attribute_must_be_present_when_saving
    client = Client.new

    refute client.save
    refute_equal 1, Client.all.size
  end

  def test_has_payload_requests
    client = Client.create(identifier: "jumpstartlabs", root_url: "http://www.jumpstartlabs.com")

    client.payload_requests.create(requested_at: "today",
                                   responded_in: 35,
                                   event_name:   "event")

    assert_equal 1, client.payload_requests.count
    assert_equal "today", client.payload_requests.last.requested_at
    assert_equal 35,      client.payload_requests.last.responded_in
    assert_equal "event", client.payload_requests.last.event_name
  end

  def test_has_ips
    client = Client.create(identifier: "jumpstartlabs", root_url: "http://www.jumpstartlabs.com")

    client.payload_requests.create(requested_at: "first_req",
                                   responded_in: 30,
                                   event_name:   "first_event",
                                   ip_address_id: IpAddress.create(ip: "127.0.0.1").id)

    client.payload_requests.create(requested_at: "second_req",
                                   responded_in: 35,
                                   event_name:   "second_event",
                                   ip_address_id: IpAddress.create(ip: "127.0.0.9").id)

    assert_equal 2, client.ip_addresses.size
    assert client.ip_addresses.pluck(:ip).include?("127.0.0.1")
    assert client.ip_addresses.pluck(:ip).include?("127.0.0.9")
  end

  def test_has_referrrers
    client = Client.create(identifier: "jumpstartlabs", root_url: "http://www.jumpstartlabs.com")

    client.payload_requests.create(requested_at: "first_req",
                                   responded_in: 30,
                                   event_name:   "first_event",
                                   referrer_id: Referrer.create(referred_by: "google.com/1").id)

    client.payload_requests.create(requested_at: "second_req",
                                   responded_in: 35,
                                   event_name:   "second_event",
                                   referrer_id: Referrer.create(referred_by: "google.com/9").id)

    assert_equal 2, client.referrers.size
    assert          client.referrers.pluck(:referred_by).include?("google.com/1")
    assert          client.referrers.pluck(:referred_by).include?("google.com/9")
  end

  def test_has_resolutions
    client = Client.create(identifier: "jumpstartlabs", root_url: "http://www.jumpstartlabs.com")

    client.payload_requests.create(requested_at: "first_req",
                                   responded_in: 30,
                                   event_name:   "first_event",
                                   resolution_id: Resolution.create(resolution_width: "1920", resolution_height: "1080").id)

    client.payload_requests.create(requested_at: "second_req",
                                   responded_in: 35,
                                   event_name:   "second_event",
                                   resolution_id: Resolution.create(resolution_width:  "1280", resolution_height: "720").id)

    assert_equal 2, client.resolutions.size
    assert          client.resolutions.pluck(:resolution_width).include?("1920")
    assert          client.resolutions.pluck(:resolution_height).include?("1080")
    assert client.resolutions.pluck(:resolution_width).include?("1280")
    assert          client.resolutions.pluck(:resolution_height).include?("720")
  end

  def test_has_url_requests
    client = Client.create(identifier: "jumpstartlabs", root_url: "http://www.jumpstartlabs.com")

    client.payload_requests.create(requested_at: "tody", responded_in: 35, event_name: 'socialLogin', url_request_id: UrlRequest.create(url: "turing.io", parameters: "string").id)

    client.payload_requests.create(requested_at: "tomorrow", responded_in: 35, event_name: 'socialLogin', url_request_id: UrlRequest.create(url: "google.com", parameters: "something").id)

    assert_equal 2, client.url_requests.size
    assert client.url_requests.pluck(:url).include?("turing.io")
    assert client.url_requests.pluck(:parameters).include?("string")
    assert client.url_requests.pluck(:url).include?("google.com")
    assert client.url_requests.pluck(:parameters).include?("something")
  end

  def test_has_user_agents
    client = Client.create(identifier: "jumpstartlabs", root_url: "http://www.jumpstartlabs.com")

    client.payload_requests.create(requested_at: "tody", responded_in: 35, event_name: 'socialLogin', user_agent_id: UserAgent.create(browser: "safari", os: "OSX").id)

    client.payload_requests.create(requested_at: "tomorrow", responded_in: 35, event_name: 'socialLogin', user_agent_id: UserAgent.create(browser: "Chrome", os: "Android").id)

    assert_equal 2, client.user_agents.size
    assert client.user_agents.pluck(:browser).include?("safari")
    assert client.user_agents.pluck(:os).include?("OSX")
    assert client.user_agents.pluck(:browser).include?("Chrome")
    assert client.user_agents.pluck(:os).include?("Android")
  end

  def test_has_verbs
    client = Client.create(identifier: "jumpstartlabs", root_url: "http://www.jumpstartlabs.com")

    client.payload_requests.create(requested_at: "tody", responded_in: 35, event_name: 'socialLogin', verb_id: Verb.create(request_type: "GET").id)

    client.payload_requests.create(requested_at: "tomorrow", responded_in: 35, event_name: 'socialLogin', verb_id: Verb.create(request_type: "POST").id)

    assert_equal 2, client.verbs.size
    assert client.verbs.pluck(:request_type).include?("GET")
    assert client.verbs.pluck(:request_type).include?("POST")
  end

  def test_event_breakdown
    client = Client.create(identifier: "jumpstartlab", root_url: "http://www.jumpstartlab.com")

    client.payload_requests.create(requested_at: "2013-02-16 21:38:28 -0700",
                                   responded_in: 35,
                                   event_name: "socialLogin")

    expected = [["21:00", 1]]

    assert_equal expected, client.event_breakdown('socialLogin')

    client.payload_requests.create(requested_at: "2013-02-16 20:38:28 -0700",
                                   responded_in: 35,
                                   event_name: "socialLogin")

    expected = [["20:00", 1], ["21:00", 1]]

    assert_equal expected, client.event_breakdown('socialLogin')

    client.payload_requests.create(requested_at: "2013-01-16 20:38:28 -0700",
                                   responded_in: 35,
                                   event_name: "socialLogin")

    expected = [["20:00", 2], ["21:00", 1]]

    assert_equal expected, client.event_breakdown('socialLogin')
  end

  def test_event_total
    client = Client.create(identifier: "jumpstartlab", root_url: "http://www.jumpstartlab.com")

    client.payload_requests.create(requested_at: "2013-02-16 21:38:28 -0700",
                                   responded_in: 35,
                                   event_name: "socialLogin")

    assert_equal 1, client.event_total('socialLogin')

    client.payload_requests.create(requested_at: "2011-02-16 21:38:28 -0700", responded_in: 35,
                                    event_name: "socialLogin")

    assert_equal 2, client.event_total('socialLogin')
  end
end
