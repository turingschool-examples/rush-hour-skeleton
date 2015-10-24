require './test/test_helper'

class ApplicationDetailTest < FeatureTest

  def test_user_can_see_thier_data_HAPPY
    save_and_open_page
    create_user(1)
    create_payloads_three
    visit '/sources/test_company_1'
    assert_equal '/sources/test_company_1', current_path

    assert page.has_content?("Most Requested URLS")
    within("#urls li:first") do
      assert page.has_content?(2)
      assert page.has_content?("http://test_company_1.com/page")
    end
    within("#urls li:last") do
      assert page.has_content?(1)
      assert page.has_content?("http://test_company_1.com/blog")
    end

    assert page.has_content?("Screen Resolution")
    within("#screen_resolution li:first") do
      assert page.has_content?(2)
      assert page.has_content?("1920 x 1280")
    end
    within("#screen_resolution li:last") do
      assert page.has_content?(1)
      assert page.has_content?("2048 x 1536")
    end

    assert page.has_content?("Web Browser Breakdown")
    within("#browser_breakdown li:first") do
      assert page.has_content?(2)
      assert page.has_content?("Chrome")
    end
    within("#browser_breakdown li:last") do
      assert page.has_content?(1)
      assert page.has_content?("Firefox")
    end

    assert page.has_content?("OS Breakdown")
    within("#os_breakdown") do
    save_and_open_page
    assert page.has_content?("Macintosh")
    end
    assert page.has_content?("Average Response Time listed longest to shortest Per URL")
    within("#responseTime li:first") do
      assert page.has_content?(1)
      assert page.has_content?(45)
    end
    within("#responseTime li:last") do
      assert page.has_content?(1)
      assert page.has_content?(27)
    end

    #Hyperlinks of each url to view url specific data
    #Hyperlink to view aggregate event data
  end

  def test_user_can_click_on_urls_to_see_detailed_data
    create_user(1)
    create_payloads_three
    visit '/sources/test_company_1'

    assert_equal '/sources/test_company_1', current_path

    within('#urls') do
      click_link("http://test_company_1.com/page")
      assert_equal '/sources/test_company_1/urls/page', current_path
    end
  end

  def test_user_can_see_thier_data_SAD
    visit '/sources/test_company_1'

    assert_equal '/sources/error', current_path

    assert page.has_content?("You Have an Error!")
  end
end
