require_relative '../test_helper'

class UserSeesAllEventsOnEventIndexPageTest < FeatureTest


  def test_user_sees_all_events_on_event_index_page_with_valid_events

    ces = ClientEnvironmentSimulator.new
    ces.start_simulation

    visit '/sources/google/events'

    assert page.has_content?("Events Index")

  end







end
