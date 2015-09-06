require "./test/test_helper"

class ShowPageFeatureTest < FeatureTest
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start

    attributes = { identifier: "jumpstartlab",
                   rootUrl: "http://jumpstartlab.com" }
    post "/sources", attributes

    assert_equal 1, Source.count
    assert_equal 200, last_response.status


    @payload = 'payload={"url":"http://jumpstartlab.com/blog","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","requestedAt":"2013-02-16 21:38:28 -0700",
               "respondedIn":37,"ip":"63.29.38.211"}'
  end

  def test_it_shows_the_header
    visit '/sources/jumpstartlab'
    within("#identifier") do
      assert page.has_content?("Dasboard")
    end
  end

  def test_it_shows_the_most_urls
    visit '/'
    assert page.has_content?("Hello, Traffic Spyer")
    visit '/sources/jumpstartlab'
    within("#most_viewed") do
      assert page.has_content?("Most Viewed Urls")
    end
  end

  def test_it_shows_the_average_response
    visit '/sources/jumpstartlab'
    within("#average_responses") do
      assert page.has_content?("Average Response Times")
    end
  end

  def test_it_shows_the_web_browser_breakdown_info
    visit '/sources/jumpstartlab'
    within("#breakdown") do
      assert page.has_content?("Web Broswer Breakdown")
    end
  end

  def test_it_shows_screen_resultion_info
    visit '/sources/jumpstartlab'
    within("#resolution") do
      assert page.has_content?("Screen Resolutions")
    end
  end

  def test_it_shows_the_operating_system_info
    visit '/sources/jumpstartlab'
    within("#os") do
      assert page.has_content?("Operating System Breakdown")
    end
    click_link "Events"
    assert_equal "/sources/jumpstartlab/events", current_path
  end

  def teardown
    DatabaseCleaner.clean
  end
end
