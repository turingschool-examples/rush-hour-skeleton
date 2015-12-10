require_relative '../test_helper'

class UserErrorForMissingPayloadTest < FeatureTest
  def test_user_gets_error_without_payload
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")
    visit '/sources/turing'
    assert page.has_content?("No Payload data has been received for this source")
  end
end 