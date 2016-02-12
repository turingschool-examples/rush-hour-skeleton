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
    create_payload_requests_with_associations(responded_in: 37)
    create_payload_requests_with_associations(responded_in: 50)
    create_payload_requests_with_associations(responded_in: 10)

    url_request = UrlRequest.all.first

    assert_equal 50, url_request.max_response_time
  end

  def test_finds_min_response_time_for_specific_url
    create_payload_requests_with_associations(responded_in: 37)
    create_payload_requests_with_associations(responded_in: 50)
    create_payload_requests_with_associations(responded_in: 10)

    url_request = UrlRequest.all.first

    assert_equal 10, url_request.min_response_time
  end

  def test_ordered_response_times_for_specific_url
    create_payload_requests_with_associations(responded_in: 50)
    create_payload_requests_with_associations(responded_in: 30)
    create_payload_requests_with_associations(responded_in: 10)
    create_payload_requests_with_associations(responded_in: 50, url: "http://google.com")

    url_request = UrlRequest.find_by(url: "http://jumpstartlab.com/blog")

    assert_equal [50, 30, 10], url_request.ordered_response_times
  end

  def test_avg_response_time_for_specific_url
    create_payload_requests_with_associations(responded_in: 50)
    create_payload_requests_with_associations(responded_in: 30)
    create_payload_requests_with_associations(responded_in: 10)

    url_request = UrlRequest.find_by(url: "http://jumpstartlab.com/blog")

    assert_equal 30, url_request.avg_response_time
  end


  def test_all_verbs_associated_with_specific_url
    create_payload_requests_with_associations
    create_payload_requests_with_associations
    create_payload_requests_with_associations(request_type: 'POST')

    url_request = UrlRequest.find_by(url: 'http://jumpstartlab.com/blog')

    assert_equal 2, url_request.associated_verbs.count
    assert url_request.associated_verbs.include?("POST")
    assert url_request.associated_verbs.include?("GET")
  end
end
