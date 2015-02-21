require './test/test_helper'

class UserViewsApplicationDetailsTest < FeatureTest

  def test_the_page_displays_the_most_requested_URLS_to_least_requested_URLS
    visit 'http://yourapplication:port/sources/jumpstartlab/events'
    assert_equal '/sources/jumpstartlab/events', current_path
    within('#event-index') do
      assert page.has_content?('Defined Events:')
   end
  end
  
# As a client
# When I visit http://yourapplication:port/sources/IDENTIFIER/events
# And events have been defined
# Then I should see a page that displays most received events to least received events
# And I should see hyperlinks of each event to view event specific data

end
