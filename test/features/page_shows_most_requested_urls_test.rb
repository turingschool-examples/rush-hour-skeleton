require_relative "../test_helper"

class PageShowMostReuqestedUrlTest < MiniTest::Test
  # def test_user_view_most_requested_url
  #   visit '/source/:identifier'
  #   click_link_or_button('Order of Requested URLs')
  #   assert_equal '/source/:identifier/url', current_path
  #   assert page.has_content?("")
  # end
  def test_user_view_most_requested_url
    visit '/show'
    assert page.has_content?("www.jumpstartlab.com")
  end

end
