require_relative '../test_helper'

class UserErrorForUnregisteredPageTest < FeatureTest
  def test_user_gets_error_if_they_try_to_view_an_unregistered_page
    visit '/sources/galvanize'
    assert page.has_content?("Identifier has not been registered")
  end
end 