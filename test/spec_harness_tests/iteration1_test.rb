require './test/test_helper'

class Iteration1Test < Minitest::Test
  def test_extract_url
    assert Url.new
  end

  def test_valid_url
    assert Url.create(root_url: "http://jumpstartlab.com",
                path: "/blog")

    url = Url.first

    assert url.respond_to?(:root_url)
    assert url.root_url.is_a?(String)
    assert url.respond_to?(:path)
    assert url.path.is_a?(String)
    assert url.respond_to?(:payload_requests)
  end

  def test_valid_referral
    assert Referral.create(root_url: "http://jumpstarlab.com",
                                path: "/blog")

    referral = Referral.first

    assert referral.respond_to?(:root_url)
    assert referral.root_url.is_a?(String)
    assert referral.respond_to?(:path)
    assert referral.path.is_a?(String)
    assert referral.respond_to?(:payload_requests)
  end

  def test_valid_request_type
    assert RequestType.create(http_verb: "get")

    request_type = RequestType.first

    assert request_type.respond_to?(:http_verb)
    assert request_type.http_verb.is_a(String)
    assert request_type.respond_to?(:payload_requests)
  end

  def test_valid_event
    assert Event.create(title: "Login")

    event = Event.first

    assert event.respond_to?(:title)
    assert event.respond_to?(:payload_requests)
  end

  def test_agent
    agent = Agent.new

    assert agent

    assert agent.respond_to?(:payload_requests)
  end

  def test_valid_resolution
    assert Resolution.create(width: "1920",
                              height: "1280")

    resolution = Resolution.first

    assert resolution.respond_to?(:width)
    assert resolution.respond_to?(:height)
    assert resolution.respond_to?(:payload_requests)
  end

  def test_payload_request_relationships_setup
    create_payload_request

    payload = PayloadRequest.new

    assert payload.respond_to?(:url)
    assert payload.respond_to?(:referral)
    assert payload.respond_to?(:request_type)
    assert payload.respond_to?(:event)
    assert payload.respond_to?(:agent)
    assert payload.respond_to?(:resolution)
  end
end
