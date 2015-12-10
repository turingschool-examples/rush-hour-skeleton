require_relative '../test_helper'

class UserErrorForUnregisteredUserViewingApplicationDetailsTest < FeatureTest
  def test_unregistered_user_gets_error_viewing_an_unregistered_page
    visit '/sources/galvanize'
    assert page.has_content?("Identifier has not been registered")
  end
end 