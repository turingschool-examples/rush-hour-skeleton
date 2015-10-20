require_relative '../test_helper'

class ApplicationEventIndexTest < MiniTest::Test

  def test_user_can_see_events_in_order
    create_user(1)
    create_event(1)
    visit '/sources/#{id}/events'

    assert page.has_content?("Most Received Events")
  end

  def user_sees_hyperlinks_to_specific_data
    create_user(1)
    create_event(1)
    visit '/sources/#{id}/events'

    assert page.has_link?('/sources/#{id}/events/#{eventname}')
  end

  def test_user_can_see_thier_data_SAD
    create_user(1)
    visit '/sources/#{id}/events'

    assert_equal '/sources/error', current_path
    assert page.has_content?("No Events have been defined")
  end

end
