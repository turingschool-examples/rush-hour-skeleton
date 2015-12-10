require './test/test_helper'
class UserErrorForEventWithoutPayloadTest < FeatureTest
  def test_displays_error_message_when_no_payload_submitted
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    visit '/sources/turing/events'

    within 'h5' do
      assert page.has_content?('No Payload data has been received for this source')
    end
  end
end
