require_relative "../test_helper"

class PayloadRequestTest < Minitest::Test
    include TestHelpers

  def setup
  @payload =  PayloadRequest.create({
                          :url_id=> "1",
                          :requested_at=> "2015-02-20",
                          :responded_in=> 37,
                          :referrer_id=> "http://jumpstartlab.com",
                          :request_id=> 2,
                          :parameters=> [],
                          :event_id=> 1,
                          :user_agent_b_id=> "1",
                          :resolution_id=> "1",
                          :ip_id=> "63.29.38.211"
                          })

  @payload2 = PayloadRequest.create({
                          :url_id=> "1",
                          :requested_at=> "",
                          :responded_in=> 100,
                          :referrer_id=> "http://jumpstartlab.com",
                          :request_id=> 1,
                          :parameters=> [],
                          :event_id=> 2,
                          :user_agent_b_id=> "1",
                          :resolution_id=> "2",
                          :ip_id=> "63.19.32.211"
                          })
  @payload3 = PayloadRequest.create({
                          :url_id=> "1",
                          :requested_at=> "2015-06-06",
                          :responded_in=> 100,
                          :referrer_id=> "http://jumpstartlab.com",
                          :request_id=> 1,
                          :parameters=> [],
                          :event_id=> 2,
                          :user_agent_b_id=> "1",
                          :resolution_id=> "2",
                          :ip_id=> "63.19.32.211"
                          })
  @payload4 = PayloadRequest.create({
                          :url_id=> "2",
                          :requested_at=> "2015-06-06",
                          :responded_in=> 100,
                          :referrer_id=> "http://jumpstartlab.com",
                          :request_id=> 1,
                          :parameters=> [],
                          :event_id=> 2,
                          :user_agent_b_id=> "1",
                          :resolution_id=> "2",
                          :ip_id=> "63.19.32.211"
                          })
  end

  def test_it_validates_new_payload_request_with_all_fields
    assert @payload.valid?
  end

  def test_it_does_not_validate_new_payload_request_with_missing_fields
    refute @payload2.valid?
  end


  def test_average_response_time
    time = PayloadRequest.all.average_response_time

    assert_equal 79, time
  end

  def test_top_request_types
    request1 = Request.create(verb: "GET")
    request2 = Request.create(verb: "POST")

    top = PayloadRequest.all.top_request_types

    assert_equal ["GET", "POST"], top
  end

  def test_url_most_requested_to_least
    url1 = Url.create(address: "www.google.com")
    url2 = Url.create(address: "www.nytimes.com")

    urls = PayloadRequest.all.url_most_requested_to_least

    assert_equal ["www.google.com", "www.nytimes.com"], urls
  end

  def test_event_most_received_to_least
    event1 = Event.create(name: "socialLogin")
    event2 = Event.create(name: "antisocialLogin")

    events = PayloadRequest.all.event_most_received_to_least

    assert_equal ["antisocialLogin", "socialLogin"], events
  end

  def test_if_all_http_verbs_are_returned
    request1 = Request.create(verb: "GET")
    request2 = Request.create(verb: "POST")

    verbs = PayloadRequest.all

    assert_equal ["POST", "GET"], verbs.all_http_verbs
  end

  def test_max_response_times_for_all_requests
    max = PayloadRequest.all.max_response_time

    assert_equal 100, max
  end

  def test_min_response_times_for_all_requests
    min = PayloadRequest.all.min_response_time

    assert_equal 37, min
  end

end
