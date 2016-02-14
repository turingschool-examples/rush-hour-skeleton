require_relative '../test_helper'

class UserCanSeeNoIdentifierTest <FeatureTest
  include Rack::Test::Methods

  def test_user_can_view_a_page_with_no_identifier
    vist 'sources/jumpstartlab'

    within('h2') do
    assert page.has_content?("Try again. This id does not exist.")
  end

end
