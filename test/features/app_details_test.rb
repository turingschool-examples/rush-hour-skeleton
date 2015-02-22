require "./test/test_helper"

class EventIndexTest < FeatureTest
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def register_identifier
    identifier =  { identifier: "jumpstartlab",
                     root_url: "http://jumpstartlab.com" }

    payload_data =  'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    Source.create(identifier)
  	post "/sources/jumpstartlab/data", payload_data
  end

  def test_registered_user_sees_application_details_page
    register_identifier
    visit "/sources/jumpstartlab"
    assert page.has_content? "URL Breakdown"
    # assert page.has_content? "Web Browser Breakdown"
    # assert page.has_content? "OS Breakdown"
    assert page.has_content? "Screen Resolution"
    assert page.has_content? "Response Time"
  end

  def test_unregistered_user_sees_identifier_does_not_exist_page
    visit "/sources/jumpstartlab"
    assert page.has_content? "Unregistered user"
  end
end
