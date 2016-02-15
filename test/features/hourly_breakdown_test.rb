require_relative '../test_helper'

class HourlyBreakdown < FeatureTest
  include TestHelpers

# http://yourapplication:port/sources/IDENTIFIER/events/EVENTNAME
#
# Examples:
#
# http://yourapplication:port/sources/jumpstartlab/events/startedRegistration
# http://yourapplication:port/sources/jumpstartlab/events/addedSocialThroughPromptA
# http://yourapplication:port/sources/jumpstartlab/events/addedSocialThroughPromptB
# Implement a hour by hour breakdown of when the event was received. How many were shown at noon? at 1pm? at 2pm? Do it for all 24 hours. Also, display on this page the overall number of times the specific event was received.
#
# When the event has not been defined: Display a message that no event with the given name has been defined and then a hyperlink to the Application Events Index.
  def test_user_can_view_hourly_breakdown_of_all_events
    create_event_specific_payloads

    #user is directed to user landing pages
    visit '/sources/jumpstartlab'
    click_link 'All Events'
    
    assert_equal '/sources/jumpstartlab/events', current_path
    #displays all events as links
    #user clicks one event_name
    click_link 'signout'

    assert_equal '/sources/jumpstartlab/events/signout', current_path


    within('.hourly-breakdown') do

      assert page.has_content? "12am - 1am"
      assert page.has_content? "1am - 2am"
      assert page.has_content? "2am - 3am"
      assert page.has_content? "3am - 4am"
      assert page.has_content? "4am - 5am"
      assert page.has_content? "5am - 6am"
      assert page.has_content? "6am - 7am"
      assert page.has_content? "7am - 8am"
      assert page.has_content? "8am - 9am"
      assert page.has_content? "9am - 10am"
      assert page.has_content? "10am - 11am"
      assert page.has_content? "11am - 12pm"
      assert page.has_content? "12pm - 1pm"
      assert page.has_content? "1pm - 2pm"
      assert page.has_content? "2pm - 3pm"
      assert page.has_content? "3pm - 4pm"
      assert page.has_content? "4pm - 5pm"
      assert page.has_content? "5pm - 6pm"
      assert page.has_content? "6pm - 7pm"
      assert page.has_content? "7pm - 8pm"
      assert page.has_content? "8pm - 9pm"
      assert page.has_content? "9pm - 10pm"
      assert page.has_content? "10pm - 11pm"
      assert page.has_content? "11pm - 12am"
    end
    #anduser can see total occurences for given event on given day
    within('#total-occurrences') { expect(page).to have_content('Total Occurrences') }
  end




end
