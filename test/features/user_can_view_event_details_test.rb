require_relative '../test_helper'

class UserCanViewEventDetailsTest < FeatureTest

  def test_user_can_view_event_details

    ces = ClientEnvironmentSimulator.new
    ces.start_simulation

    visit '/sources/google/events/Dad'

    assert page.has_content?("Event Details")

  end



end
