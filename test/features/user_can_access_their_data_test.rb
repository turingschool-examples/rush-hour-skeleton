require './test/test_helper'

class ApplicationDetailTest < FeatureTest

  def test_user_can_see_thier_data_HAPPY
    skip
    create_user(1)
    create_payloads_three
    visit '/sources/test_company_1'

    assert_equal '/sources/test_company_1', current_path

    assert page.has_content?("Most Requested URLS")
    within("#urls li:first") do
     assert page.has_content?(2)
     assert page.has_content?("http://jumpstartlab.com/page")
    end
    within("#urls li:last") do
      assert page.has_content?(1)
      assert page.has_content?("http://jumpstartlab.com/blog")
    end

    assert page.has_content?("Web Browser Breakdown")
    within("#screen_resolution li:first") do
      save_and_open_page
      assert page.has_content?(2)
      assert page.has_content?("1920 x 1280")
    end
    within("#screen_resolution li:last") do
      assert page.has_content?(1)
      assert page.has_content?("2048 x 1536")
    end

    # assert page.has_content?("OS Breakdown")
    # assert page.has_content?("Screen Resolution")
    assert page.has_content?("Average Response Time listed longest to shortest Per URL")
    within("#responseTime li:first") do
      save_and_open_page
      assert page.has_content?(1)
      assert page.has_content?(45)
    end
    within("#responseTime li:last") do
      assert page.has_content?(1)
      assert page.has_content?(27)
    end
    # assert page.has_content?("Most Requested URLS")
    # assert page.has_content?("Most Requested URLS")
    #Hyperlinks of each url to view url specific data
    #Hyperlink to view aggregate event data
  end

  def test_user_can_see_thier_data_SAD
    skip
    visit '/sources/test_company_1'

    # assert_equal '/sources/error', current_path

    assert page.has_content?("Error Page")
  end













end
