require './test/test_helper'

class UrlSpecificDataPageTest < FeatureTest
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start

    attributes = {identifier: "jumpstartlab",
                  rootUrl: "http://jumpstartlab.com"
                }
    post "/sources", attributes

    assert_equal 1, Source.count
    assert_equal 200, last_response.status

    @payload = 'payload={"url":"http://jumpstartlab.com/blog",
                        "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                        "resolutionWidth":"1920",
                        "resolutionHeight":"1280",
                        "requestedAt":"2013-02-16 21:38:28 -0700",
                        "respondedIn":37,"ip":"63.29.38.211"}'


  end

  def test_header_is_displayed
    post "/sources/jumpstartlab/data", @payload
    visit '/sources/jumpstartlab/urls/blog'
    within("#header") do
      assert page.has_content?("Url Specific Data")
    end
  end

  def teardown
    DatabaseCleaner.clean
  end
end
