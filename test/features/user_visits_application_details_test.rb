require_relative '../test_helper'

class UserVisitsApplicationDetailsTest < FeatureTest

  def test_user_can_view_most_requested_urls
    visit '/sources/yahoo'

    within('#mvp_urls') do
      assert page.has_content?('URL Popularity Contest')
      assert page.has_content?('weather')
    end
  end

end
