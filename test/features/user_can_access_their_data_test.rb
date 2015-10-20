require_relative '../test_helper'

class ApplicationDetailTest < MiniTest::Test

  def test_user_can_see_thier_data_HAPPY
    create_user(1)
    visit '/sources/test_company_1'

    assert_equal '/sources/test_company_1', current_path

    assert page.has_content?("Most Requested URLS")
    assertpage.has_css?("#urls")
    assert page.has_content?("Web Browser Breakdown")
    assert page.has_content?("OS Breakdown")
    assert page.has_content?("Screen Resolution")
    assert page.has_content?("Average Response Time Per URL")
    assert page.has_content?("Most Requested URLS")
    assert page.has_content?("Most Requested URLS")
    #Hyperlinks of each url to view url specific data
    #Hyperlink to view aggregate event data
  end

  def test_user_can_see_thier_data_SAD
    visit '/sources/test_company_1'

    assert_equal '/sources/error', current_path

    assert page.has_content?("Test Company 1 is not a user of traffic spy")
  end

end
