require_relative '../test_helper'

class ErrorTest < FeatureTest

  def test_user_will_get_an_error_for_no_id
     User.create("rootUrl" => "HTTP://Example1.com")
     Payload.create({url: "http://jumpstartlab.com/page",
                     requestedAt: "2013-02-16 21:38:28 -0700",
                     respondedIn: 45,
                     referredBy: "http://jumpstartlab.com",
                     requestType: "GET",
                     eventName:  "socialLogin",
                     userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                     resolutionWidth: "1920",
                     resolutionHeight: "1280",
                     sha: "12abedfog8erevdaddg",
                     user_id: "test_company_1",
                     ip: "63.29.38.211"})
    visit '/sources/test_company_1'
    assert_equal'/sources/error', current_path
    within("#error li:first") do
    assert page.has_content?("error")
    end
  end

    def test_user_will_get_an_error_for_no_event
       User.create("rootUrl" => "HTTP://Example1.com")
       Payload.create({url: "http://jumpstartlab.com/page",
                       requestedAt: "2013-02-16 21:38:28 -0700",
                       respondedIn: 45,
                       referredBy: "http://jumpstartlab.com",
                       requestType: "GET",

                       userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                       resolutionWidth: "1920",
                       resolutionHeight: "1280",
                       sha: "12abedfog8erevdaddg",
                       user_id: "test_company_1",
                       ip: "63.29.38.211"})
      visit '/sources/test_company_1/events'
      assert_equal'/sources/error', current_path
      within("#error li:first") do
      assert page.has_content?("error")
    end
  end
end
