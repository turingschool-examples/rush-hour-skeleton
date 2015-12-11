require './test/test_helper'

class UserErrorForUndefinedEventTest < FeatureTest
  def test_user_cannot_view_details_of_an_undefined_event
    register_turing_and_send_multiple_payloads

    visit '/sources/turing/events/socialZZYZX'

    within 'h3' do
      assert page.has_content?('event: socialZZYZX has not been defined for this application')
    end

    assert page.has_css?("a[href~='/sources/turing/events']")
  end
end
