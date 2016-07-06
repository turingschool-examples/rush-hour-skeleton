require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test


#1. Test that it can be created
#2. Test that it does not get created with bad/no info
#3. Test that it has a relationship using name.respond_to?(:attribute)

  def payload_request
    payload = '{
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }'
  end

  def test_that_it_creates_a_payload_request
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: 1, referral_id: 1, request_type_id: 1, user_agent_device_id: 1, resolution_id: 1, ip_id: 1)

    
    assert pr.valid?
    #can do individually for each validation,
    #payload_request.url -- that will test the connection b/w pr and url and get a certain url
    #want to make sure we can use pr.url and can use method respond_to?(:url)
    #pr.respond_to?(:url) wont' pass until it belongs to (sets up the relationship)

  end


end
