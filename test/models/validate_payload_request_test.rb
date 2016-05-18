require_relative "../test_helper"

class ValidatePayloadRequestTest < Minitest::Test

  def setup
    @payload = PayloadRequest.create({
                          "url": "http://jumpstartlab.com/blog",
                          "requested_at": "dhbfkhsdij",
                          "responded_in": 37,
                          "referred_by": "http://jumpstartlab.com",
                          "request_type": "GET",
                          "parameters": [],
                          "event_name": "socialLogin",
                          "user_agent_id": "1",
                          "resolution_id": "1",
                          "ip": "63.29.38.211"
                          })
    @payload2 = PayloadRequest.create({
                          "url": "http://jumpstartlab.com/blog",
                          "requested_at": "",
                          "responded_in": 37,
                          "referred_by": "http://jumpstartlab.com",
                          "request_type": "GET",
                          "parameters": [],
                          "event_name": "socialLogin",
                          "user_agent_id": "1",
                          "resolution_id": "1",
                          "ip": "63.29.38.211"
                          })
  end

  def test_it_validates_new_payload_request_with_all_fields
    assert @payload.valid?
  end

  def test_it_validates_new_payload_request_with_missing_fields
    refute @payload2.valid?
  end

  def test_it_takes_in_url
    assert_equal "http://jumpstartlab.com/blog", @payload.url
  end

end
