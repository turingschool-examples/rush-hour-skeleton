require './test/test_helper'

class UserViewsApplicationDetailsTest < FeatureTest

  def test_the_page_displays_the_most_received_events_to_least_received_events
    skip
    visit 'http://yourapplication:port/sources/jumpstartlab/events'
    assert_equal '/sources/jumpstartlab/events', current_path
    within('#event-index') do
      assert page.has_content?('Events:')
   end
  end

  def test_there_are_hyperlinks_of_each_event_to_display_event_specific_data
    skip
    visit 'http://yourapplication:port/sources/jumpstartlab/events'
    assert_equal '/sources/jumpstartlab/events', current_path
    within('#event-index') do
      click_link_or_button("Event-'name'")
      assert_equal "/sources/jumpstartlab/events/'name'"
   end

  end

# As a client
# When I visit http://yourapplication:port/sources/IDENTIFIER/events
# And events have been defined
# Then I should see a page that displays most received events to least received events
# And I should see hyperlinks of each event to view event specific data

end
