require_relative '../test_helper'

class UserCanViewEventDetailsTest < FeatureTest

  def test_user_can_view_event_details

    ces = ClientEnvironmentSimulator.new
    ces.start_simulation

    visit '/sources/google/events/Dad?'

    save_and_open_page

    assert page.has_content?("Event Details")


  end



end
