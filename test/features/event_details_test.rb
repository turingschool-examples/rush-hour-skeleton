require "./test/test_helper"

class EventDetailsTest < FeatureTest
   
   def test_user_sees_overall_number_of_event_details
    skip
    visit "/sources/jumpstartlab/events/startedRegistration"
    assert page.has_content?("received")
  end 

  def test_user_sees_event_details_by_hour
    skip
    visit "/sources/jumpstartlab/events/startedRegistration"
    assert page.has_content?("Hour by Hour")
  end 

end