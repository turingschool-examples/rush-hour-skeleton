require_relative '../test_helper'

class HomePageTest < FeatureTest
  def test_a_user_can_view_the_homepage
    visit '/'

    assert page.has_content?('Hello, Traffic Spyer')

    click_link('start')

    assert_equal current_path, '/sources'
  end
end
