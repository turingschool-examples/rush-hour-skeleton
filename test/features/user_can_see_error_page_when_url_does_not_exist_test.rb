require_relative '../test_helper'

class ErrorPageTest < FeatureTest
  def test_a_user_can_view_error_page_when_identifier_does_not_exist
    visit '/sources/nonexistent_in_db'

    assert page.has_content?('Error Page')
  end
end
