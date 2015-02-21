require "./test/test_helper"

class EventDetailsTest < FeatureTest
  #After I click on the event hyperlink
  #then I see the hour by hour breakdown of when the event was received
  #then I see how many times it was received overall
  def test_user_sees_event_details_by_hour
  	visit "/sources/jumpstartlab/events/startedRegistration"
    within('#events-detail-hour') do
      assert page.has_content?("Hour by Hour")
    end
  end 
   
   def test_user_sees_overall_number_of_event_details
    visit "/sources/jumpstartlab/events/startedRegistration"
    within('#events-detail-overall') do
      assert page.has_content?("received")
    end
  end 

end