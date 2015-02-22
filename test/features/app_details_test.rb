require "./test/test_helper"

class EventIndexTest < FeatureTest

  def test_registered_user_sees_application_details_page
    register_user_and_create_payload
    visit "/sources/jumpstartlab"
    assert page.has_content? "URL Breakdown"
    assert page.has_content? "Browser Breakdown"
    assert page.has_content? "OS Breakdown"
    assert page.has_content? "Screen Resolution"
    assert page.has_content? "Response Time"
  end

  def test_unregistered_user_sees_identifier_does_not_exist_page
    visit "/sources/jumpstartlab"
    assert page.has_content? "Unregistered user"
  end
end
