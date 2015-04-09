require './test/test_helper'

class ApplicationDetailsTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
    TestData.clients.each do |client|
      ClientValidator.validate(client["identifier"])
    end
    TestData.payloads.each do |payload|
      client = "jumpstartlab&rootUrl=http://jumpstartlab.com"
      PayloadValidator.validate(payload["payload"], client)
    end
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_it_finds_and_list_urls_from_most_requested_to_least_requested
    result = ApplicationDetails.sort_tracked_sites(1)
    assert_equal "http://yahoo.com/weather", result.first
  end

  def test_web_browser_can_be_broken_down_across_all_requests
    result = ApplicationDetails.user_agent_browser(1)
    assert_equal ["Chrome"],result
  end

  def test_OS_can_be_broken_down_across_all_requests
    result = ApplicationDetails.user_agent_os(1)
    assert_equal ["Macintosh%3B Intel Mac OS X 10_8_2", "Windows"],result
  end

  def test_it_can_return_resolutions_across_all_requests
    result = ApplicationDetails.resolutions(1)
    assert_equal ["1280 x 1920", "480 x 640", "1080 x 1920", "600 x 800", "700 x 500"], result
  end

  def test_it_can_find_average_response_time_per_url
    result = ApplicationDetails.average_response(1)
    expected = {"http://yahoo.com/weather"=>91, "http://yahoo.com/news"=>123, "http://google.com/about"=>315, "http://apple.com/blog"=>105, "http://jumpstartlab.com/blog"=>37}
    # JOSH MAGIC
    # client.urls.each do |url|
    #   url.average_response_time
    # end
    assert_equal expected, result
  end

  def test_it_can_return_event_data
    result = ApplicationDetails.get_event_data(1, 1)
    assert_equal "",""
  end

end
