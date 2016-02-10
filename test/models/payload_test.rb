require_relative '../test_helper'

class PayloadTest < Minitest::Test
  include TestHelpers

  def test_it_finds_the_average_response_time_across_requests
    create_payloads(2)
    assert_equal 52.0, Payload.average_response_time
  end

  def test_it_finds_max_response_time
    create_payloads(2)
    assert_equal 67.0, Payload.max_response_time
  end

  def test_it_finds_minimum_response_time
    create_payloads(2)
    assert_equal 37.0, Payload.min_response_time
  end

  def test_most_frequent_request_type
    create_payloads(3)
    assert_equal "GET", Payload.most_frequent_request
  end

  def test_unique_Http_verbs
    create_payloads(3)
    assert_equal ["GET", "POST"], Payload.verbs_used.sort
  end

  def test_list_urls_by_great_request_count
    create_payloads(4)
    urls = ["http://jumpstartlab.com/about", "http://jumpstartlab.com/blog", "http://google.com/about"]
    assert_equal urls, Payload.most_frequent_urls
  end

  def test_web_browser_breakdown_across_requests
    create_payloads(4)
    assert_equal ["Chrome 24.0.1309", "AOL 9.7.4343"], Payload.browser_breakdown
  end

  def test_os_breakdown_across_requests
    create_payloads(4)
    assert_equal ["Mac OS X 10.8.2", "Windows 7"], Payload.os_breakdown
  end

  def test_screen_resolution_breakdown
    create_payloads(4)
    assert_equal ["1920x1280", "1920x1080"], Payload.screen_resolution_breakdown
  end


end
