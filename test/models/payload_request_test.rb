require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_payload_request_with_valid_attributes
    create_payload(1)
    payload = PayloadRequest.find(1)

    assert_equal 1, payload.id
    assert_equal 1, payload.resolution_id
    assert_equal 1, payload.referred_by_id
    assert_equal "http://jumpstartlab.com/blog0", payload.url.address
    assert_equal "http://jumpstartlab.com0", payload.referrer.address
    assert_equal "GET", payload.request_type.verb
    assert_equal "Chrome0", payload.software_agent.browser
    assert_equal "OSX 10.11.50", payload.software_agent.os
    assert_equal "19200", payload.resolution.width
    assert_equal "12800", payload.resolution.height
    assert_equal 0, payload.responded_in
    assert_equal "63.29.38.2110", payload.ip.address
end

  def test_find_average
    create_payload(3)

    assert_equal 1, PayloadRequest.average(:responded_in).to_i
  end

  def test_max_response_time
    create_payload(3)

    assert_equal 2, PayloadRequest.maximum(:responded_in)
  end

  def test_min_response_time
    create_payload(3)

    assert_equal 0, PayloadRequest.minimum(:responded_in)
  end

  def test_most_common_type_of_request
    create_payload(3)

    assert_equal "GET", PayloadRequest.most_frequent_type
  end

  def test_list_of_http_verbs_used
    create_payload(3)
    assert_equal ["GET", "GET", "GET"], PayloadRequest.list_of_http_verbs_used
  end


  def test_find_max_response_by_url
    create_payload(3)

    assert_equal 0, PayloadRequest.find_max_response_by_url("http://jumpstartlab.com/blog0")
  end

  def test_find_min_response_by_url
    create_payload(3)

    assert_equal 0, PayloadRequest.find_min_response_by_url("http://jumpstartlab.com/blog0")
  end

  # def test_find_request_types_by_url
  #   PayloadRequest.create('{
  #                           "url":"http://jumpstartlab.com/blog",
  #                           "requestedAt":"2013-02-16 21:38:28 -0700",
  #                           "respondedIn":37,
  #                           "referredBy":"http://jumpstartlab.com",
  #                           "requestType":"GET",
  #                           "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
  #                           "resolutionWidth":"1920",
  #                           "resolutionHeight":"1280",
  #                           "ip":"63.29.38.211"
  #   }')
  #
  #   assert_equal 0, PayloadRequest.specific_url_request_types("http://jumpstartlab.com/blog0")
  # end
end
