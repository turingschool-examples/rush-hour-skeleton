require_relative '../test_helper'

class ApplicationEventIndexTest < FeatureTest

  def test_user_can_see_events_in_order
    create_user(1)
    create_payloads_three

    visit "/sources/test_company_1/events"

    assert page.has_content?("Most Received Events")

    within("#events li:first") do
      assert page.has_content?(2)
      assert page.has_content?("socialLogin")
    end
    within("#events li:last") do
      assert page.has_content?(1)
      assert page.has_content?("beginRegistration")
    end
  end

  def test_user_can_click_on_urls_to_see_specific_event_data
    create_user(1)
    create_payloads_three
    visit '/sources/test_company_1/events'

    assert_equal '/sources/test_company_1/events', current_path

    within('#events') do
      click_link("socialLogin")
      assert_equal '/sources/test_company_1/events/socialLogin', current_path
    end
  end

  def test_user_cant_see_thier_data_if_it_doesnt_exist_SAD
    create_user(1)
    Payload.create({url: "http://test_company_1.com/page",
                    requestedAt: "2013-02-16 21:38:28 -0700",
                    respondedIn: 45,
                    referredBy: "http://test_company_1.com",
                    requestType: "GET",
                    # eventName:  "",
                    userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                    resolutionWidth: "1920",
                    resolutionHeight: "1280",
                    sha: "12abedfog8erevdaddg",
                    user_id: "test_company_1",
                    ip: "63.29.38.211"})
    visit '/sources/test_company_1/events'

    assert_equal '/sources/error', current_path
    assert page.has_content?("error")
  end

end
