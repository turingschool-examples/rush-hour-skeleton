require_relative '../test_helper'

class TestClientSeesThatIdentifierDoesntExist < FeatureTest
  def test_client_sees_error
    visit '/sources/jumpstartlab'

    assert page.has_content?("jumpstartlab does not exist")
  end
end
