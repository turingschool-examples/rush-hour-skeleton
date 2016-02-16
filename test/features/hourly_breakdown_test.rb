require_relative '../test_helper'

class HourlyBreakdown < FeatureTest
  include TestHelpers

  def test_user_can_view_hourly_breakdown_of_all_events
    create_event_specific_payloads

    visit '/sources/jumpstartlab'
    click_link 'All Events'

    assert_equal '/sources/jumpstartlab/events', current_path

    click_link 'signOut'

    assert_equal '/sources/jumpstartlab/events/signOut', current_path

    within('.total-occurrences') do
      assert page.has_content? 'Total Occurrences'
      assert page.has_content? '2'
    end

    within('.hourly-breakdown') do
      assert page.has_content? 'Hour'

    end
  end
end
