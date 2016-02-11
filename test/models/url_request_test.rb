require_relative '../test_helper'

class UrlRequestTest < Minitest::Test
  include TestHelpers

  def test_has_attributes
    ur = UrlRequest.new

    assert_respond_to ur, :url
    assert_respond_to ur, :parameters
  end

  def test_attributes_must_be_present_when_saving
    url_request = UrlRequest.new

    refute url_request.save
    refute_equal 1, UrlRequest.all.count
  end

  def test_finds_max_response_time_for_specific_url
    payload_request_1 = PayloadRequest.create(requested_at: payload[:requestedAt],
                                              responded_in: 37,
                                              event_name: "socialLogin")
    payload_request_2 = PayloadRequest.create(requested_at: payload[:requestedAt],
                                              responded_in: 50,
                                              event_name: "socialLogin")
    payload_request_3 = PayloadRequest.create(requested_at: payload[:requestedAt],
                                              responded_in: 10,
                                              event_name: "socialLogin")
    url_request = UrlRequest.create(url: payload[:url],
                            parameters: "[]")
    payload_request_1.update(url_request_id: url_request.id)
    payload_request_2.update(url_request_id: url_request.id)
    payload_request_3.update(url_request_id: url_request.id)
    
    assert_equal 50, url_request.max_response_time
  end
end
