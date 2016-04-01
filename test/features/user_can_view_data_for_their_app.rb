require_relative '../test_helper'

class UserCanViewDataForTheirApp < FeatureTest
  include TestHelpers

  def test_viewer_can_visit_their_page
    path = '/sources/jumpstartlab'
    visit path

    assert_equal path, current_path
  end
end
