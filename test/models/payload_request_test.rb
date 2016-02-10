require_relative "../test_helper"

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
