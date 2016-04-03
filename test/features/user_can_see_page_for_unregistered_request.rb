require_relative '../test_helper'

class UserCanViewPageForNoPayloadRequest< FeatureTest
  include TestHelpers

  def test_user_see_page_for_no_payload_request
    setup_client
    path = '/sources/jumpstartlab'
    visit path

    assert_equal path, current_path

    within("h2") do
      assert page.has_content?("Client is registered, but no requests have been received")
    end
  end
end

