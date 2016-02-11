require_relative "../test_helper"
require 'pry'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_all_attributes_exist
    pr = PayloadRequest.new
    assert_respond_to pr, :url
    assert_respond_to pr, :requested_at
    assert_respond_to pr, :responded_in
    assert_respond_to pr, :referrer
    assert_respond_to pr, :request
    assert_respond_to pr, :event
    assert_respond_to pr, :user_agent
    assert_respond_to pr, :resolution
    assert_respond_to pr, :ip
    assert_respond_to pr, :url_id
    assert_respond_to pr, :referrer_id
    assert_respond_to pr, :request_id
    assert_respond_to pr, :event_id
    assert_respond_to pr, :user_agent_id
    assert_respond_to pr, :resolution_id
    assert_respond_to pr, :ip_id
  end

  def test_can_add_a_payload_request_to_database
    pr0 = PayloadRequest.new(example_payload)
    assert pr0.save

    pr = PayloadRequest.all.first
    assert_equal 1, PayloadRequest.all.count
    assert_equal 'http://jumpstartlab.com/blog', pr.url.address
    assert_equal "2013-02-16 21:38:28 -0700", pr.requested_at
    assert_equal 37, pr.responded_in
    assert_equal 'http://jumpstartlab.com', pr.referrer.address
    assert_equal "GET", pr.request.verb
    assert_equal "socialLogin", pr.event.name
    assert_equal "Chrome", pr.user_agent.browser
    assert_equal "Macintosh", pr.user_agent.platform
    assert_equal "1920", pr.resolution.width
    assert_equal "1280", pr.resolution.height
    assert_equal "63.29.38.211", pr.ip.address
    assert_equal 1, pr.url_id
    assert_equal 1, pr.referrer_id
    assert_equal 1, pr.request_id
    assert_equal 1, pr.event_id
    assert_equal 1, pr.user_agent_id
    assert_equal 1, pr.resolution_id
    assert_equal 1, pr.ip_id
  end

  def test_will_not_create_payload_request_without_all_params
    example_payload.keys.each do |key|
      payload = example_payload
      payload.delete(key)
      PayloadRequest.create(payload)
      assert_equal 0, PayloadRequest.all.count
    end
  end

  def test_will_not_create_payload_request_when_request_details_are_empty
    example_payload.each do |key,value|
      if value.class == String
        payload = example_payload
        payload[key] = ""
        PayloadRequest.create(payload)
        assert_equal 0, PayloadRequest.all.count
      end
    end
  end

  def example_payload
    ({
      url: Url.find_or_create_by(address: 'http://jumpstartlab.com/blog'),
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referrer: Referrer.find_or_create_by(address: 'http://jumpstartlab.com'),
      request: Request.find_or_create_by(verb: "GET"),
      event: Event.find_or_create_by(name: 'socialLogin'),
      user_agent: UserAgent.find_or_create_by(browser: "Chrome", platform: "Macintosh"),
      resolution: Resolution.find_or_create_by(width: "1920", height: "1280"),
      ip: Ip.find_or_create_by(address: "63.29.38.211")
    })
  end

end


class CalculationsOnPayloadRequestTest< Minitest::Test
  include TestHelpers

  def test_average_response_time_all_requests
    #setup
    rp1 = raw_payload
    rp2 = raw_payload
    rp2[:respondedIn] = 40
    rp3 = raw_payload
    rp3[:respondedIn] = 20
    #require 'pry';binding.pry
    #actions
    PayloadRequest.create(PayloadParser.parse(rp1))
    PayloadRequest.create(PayloadParser.parse(rp2))
    PayloadRequest.create(PayloadParser.parse(rp3))

    #assertions
    assert_equal 32.33, PayloadRequest.average_response_time
  end

  def test_max_response_time_across_all_requests
    rp1 = raw_payload
    rp2 = raw_payload
    rp2[:respondedIn] = 40
    rp3 = raw_payload
    rp3[:respondedIn] = 20

    PayloadRequest.create(PayloadParser.parse(rp1))
    PayloadRequest.create(PayloadParser.parse(rp2))
    PayloadRequest.create(PayloadParser.parse(rp3))

    assert_equal 40, PayloadRequest.find_max_response_time
  end

  def test_min_response_time_across_all_requests
    rp1 = raw_payload
    rp2 = raw_payload
    rp2[:respondedIn] = 40
    rp3 = raw_payload
    rp3[:respondedIn] = 20

    PayloadRequest.create(PayloadParser.parse(rp1))
    PayloadRequest.create(PayloadParser.parse(rp2))
    PayloadRequest.create(PayloadParser.parse(rp3))

    assert_equal 20, PayloadRequest.find_min_response_time
  end

  def test_find_the_most_frequent_request_type
    rp1 = raw_payload
    rp2 = raw_payload
    rp2[:requestType] = "hey now"
    rp3 = raw_payload
    rp3[:requestType] = "hey now"
    rp4 = raw_payload
    rp4[:requestType] = "hey now"
    rp5 = raw_payload
    rp5[:requestType] = "hey now"


    PayloadRequest.create(PayloadParser.parse(rp1))
    PayloadRequest.create(PayloadParser.parse(rp2))
    PayloadRequest.create(PayloadParser.parse(rp3))
    PayloadRequest.create(PayloadParser.parse(rp4))
    PayloadRequest.create(PayloadParser.parse(rp5))

    assert_equal "hey now", PayloadRequest.find_most_frequent_request_type
  end

  def test_returns_list_of_all_HTTP_verbs
    rp1 = raw_payload
    rp2 = raw_payload
    rp2[:requestType] = "hey now"
    rp3 = raw_payload
    rp3[:requestType] = "hey now"
    rp4 = raw_payload
    rp4[:requestType] = "hey now"
    rp5 = raw_payload
    rp5[:requestType] = "hey now"


    PayloadRequest.create(PayloadParser.parse(rp1))
    PayloadRequest.create(PayloadParser.parse(rp2))
    PayloadRequest.create(PayloadParser.parse(rp3))
    PayloadRequest.create(PayloadParser.parse(rp4))
    PayloadRequest.create(PayloadParser.parse(rp5))

    assert_equal ["GET", "hey now"], PayloadRequest.find_all_http_verbs
  end

  def test_returns_list_of_URLs_from_most_frequent_to_least_frequent
    rp1 = raw_payload
    rp2 = raw_payload
    rp2[:url] = "www.google.com"
    rp3 = raw_payload
    rp3[:url] = "www.google.com"
    rp4 = raw_payload
    rp4[:url] = "www.turing.io"
    rp5 = raw_payload
    rp6 = raw_payload

    PayloadRequest.create(PayloadParser.parse(rp1))
    PayloadRequest.create(PayloadParser.parse(rp2))
    PayloadRequest.create(PayloadParser.parse(rp3))
    PayloadRequest.create(PayloadParser.parse(rp4))
    PayloadRequest.create(PayloadParser.parse(rp5))
    PayloadRequest.create(PayloadParser.parse(rp6))

    assert_equal ["http://jumpstartlab.com/blog", "www.google.com", "www.turing.io"], PayloadRequest.return_ordered_list_of_urls
  end

  def test_find_max_response_time_for_specific_URL
    rp1 = raw_payload
    rp2 = raw_payload
    rp2[:respondedIn] = 40
    rp2[:url] = "www.google.com"
    rp3 = raw_payload
    rp3[:respondedIn] = 50
    rp3[:url] = "www.google.com"
    rp4 = raw_payload
    rp4[:respondedIn] = 60
    rp5 = raw_payload
    rp5[:respondedIn] = 70
    rp6 = raw_payload
    rp6[:respondedIn] = 80

    PayloadRequest.create(PayloadParser.parse(rp1))
    PayloadRequest.create(PayloadParser.parse(rp2))
    PayloadRequest.create(PayloadParser.parse(rp3))
    PayloadRequest.create(PayloadParser.parse(rp4))
    PayloadRequest.create(PayloadParser.parse(rp5))
    PayloadRequest.create(PayloadParser.parse(rp6))
    url = Url.all.first
    url2 = Url.all.last

    assert_equal 80, url.find_max_response_time
    assert_equal 50, url2.find_max_response_time
  end

  def test_find_min_response_time_for_specific_URL
    rp1 = raw_payload
    rp2 = raw_payload
    rp2[:respondedIn] = 40
    rp2[:url] = "www.google.com"
    rp3 = raw_payload
    rp3[:respondedIn] = 50
    rp3[:url] = "www.google.com"
    rp4 = raw_payload
    rp4[:respondedIn] = 60
    rp5 = raw_payload
    rp5[:respondedIn] = 70
    rp6 = raw_payload
    rp6[:respondedIn] = 80

    PayloadRequest.create(PayloadParser.parse(rp1))
    PayloadRequest.create(PayloadParser.parse(rp2))
    PayloadRequest.create(PayloadParser.parse(rp3))
    PayloadRequest.create(PayloadParser.parse(rp4))
    PayloadRequest.create(PayloadParser.parse(rp5))
    PayloadRequest.create(PayloadParser.parse(rp6))
    url = Url.all.first
    url2 = Url.all.last

    assert_equal 37, url.find_min_response_time
    assert_equal 40, url2.find_min_response_time
  end

  def test_returns_list_of_response_times_for_specific_url
    rp1 = raw_payload
    rp2 = raw_payload
    rp2[:respondedIn] = 40
    rp2[:url] = "www.google.com"
    rp3 = raw_payload
    rp3[:respondedIn] = 50
    rp3[:url] = "www.google.com"
    rp4 = raw_payload
    rp4[:respondedIn] = 60
    rp5 = raw_payload
    rp5[:respondedIn] = 70
    rp6 = raw_payload
    rp6[:respondedIn] = 80

    PayloadRequest.create(PayloadParser.parse(rp1))
    PayloadRequest.create(PayloadParser.parse(rp2))
    PayloadRequest.create(PayloadParser.parse(rp3))
    PayloadRequest.create(PayloadParser.parse(rp4))
    PayloadRequest.create(PayloadParser.parse(rp5))
    PayloadRequest.create(PayloadParser.parse(rp6))
    url = Url.all.first
    url2 = Url.all.last

    assert_equal [80, 70, 60, 37], url.list_response_times
    assert_equal [50, 40], url2.list_response_times
  end

  def test_average_response_time_for_specific_url
    rp1 = raw_payload
    rp2 = raw_payload
    rp2[:respondedIn] = 40
    rp2[:url] = "www.google.com"
    rp3 = raw_payload
    rp3[:respondedIn] = 50
    rp3[:url] = "www.google.com"
    rp4 = raw_payload
    rp4[:respondedIn] = 60
    rp5 = raw_payload
    rp5[:respondedIn] = 70
    rp6 = raw_payload
    rp6[:respondedIn] = 80

    PayloadRequest.create(PayloadParser.parse(rp1))
    PayloadRequest.create(PayloadParser.parse(rp2))
    PayloadRequest.create(PayloadParser.parse(rp3))
    PayloadRequest.create(PayloadParser.parse(rp4))
    PayloadRequest.create(PayloadParser.parse(rp5))
    PayloadRequest.create(PayloadParser.parse(rp6))
    url = Url.all.first
    url2 = Url.all.last


    assert_equal 61.75, url.find_average_response_time
    assert_equal 45, url2.find_average_response_time
  end

  def raw_payload
    ({
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    })
  end
end
