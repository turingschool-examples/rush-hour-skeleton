require "./test/test_helper"

class EventDetailsTest < FeatureTest
   
  def payload_generator
    params = '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    identifier = "jumpstartlab"

    PayloadGenerator.call(params, identifier)
  end

   def test_user_sees_overall_number_of_event_details
    Source.create(:identifier => "jumpstartlab",
                  :root_url => "jump.com")
    payload_generator
    visit "/sources/jumpstartlab/events/socialLogin"
    assert page.has_content?("received")
  end 

  def test_user_sees_event_details_by_hour
    Source.create(:identifier => "jumpstartlab",
                  :root_url => "jump.com")
    payload_generator
    visit "/sources/jumpstartlab/events/socialLogin"
    assert page.has_content?("Hour by Hour")
  end 

end