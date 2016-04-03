require_relative '../test_helper'

class UserCanNoViewNoRegistrationPage< FeatureTest
  include TestHelpers

  def test_user_see_a_no_registration_page
    path = '/sources/torchystacos'
    visit path

    assert_equal path, current_path

    assert page.has_content?("Client not registered")
   # assert page.has_content?("Back to Events") #TODO need to redirec to a registration page
  end
end
