require_relative "../test_helper"

class PageShowMostReuqestedUrlTest < FeatureTest
  def test_user_view_most_requested_url
    visit '/source/:identifier'
    click_link_or_button('Order of Requested URLs')
    assert_equal '/source/:identifier/url', current_path
    assert page.has_content?("")
  end

end
