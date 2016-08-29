require_relative '../test_helper'

class TestClientSeesThatPayloadDoesntExist < FeatureTest
  def test_client_sees_error
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    visit '/sources/jumpstartlab'

    assert page.has_content?("No payload data has been received for jumpstartlab")
  end
end
