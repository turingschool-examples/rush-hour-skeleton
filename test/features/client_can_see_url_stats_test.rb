require_relative '../test_helper'

class ClientCanSeeAvgResponseTimeTest < FeatureTest
  include TestHelpers

  def test_client_can_see_url_stats
    post "/sources", { identifier: "jumpstartlabs",
                       rootUrl:   "http://jumpstartlab.com" }
    post "/sources/jumpstartlabs/data", { payload: payload.to_json }

    payload_2 = payload( responded_in: 30, referred_by: "facebook.com", request_type: "POST", user_agent: "Mozilla33.5 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0,POST.2564.103 Safari/537.36")
    post "/sources/jumpstartlabs/data", { payload: payload_2.to_json }
    post "/sources/jumpstartlabs/data", { payload: alternate_payload.to_json }

    visit "/sources/jumpstartlabs/urls"

    click_link "http://jumpstartlab.com/blog"

    assert_equal '/sources/jumpstartlabs/urls/blog', current_path
    within 'h1' do
      assert page.has_content? "Url Statistics"
    end
    within '.url-stats' do
      assert page.has_content? "Maximum Response Time"
      assert page.has_content? "37"
      assert page.has_content? "Minimum Response Time"
      assert page.has_content? "30"
      assert page.has_content? "Response Times in Descending order"
      assert page.has_content? "37, 30"
      assert page.has_content? "Average Response Time"
      assert page.has_content? "33.5"
      assert page.has_content? "All Associated Verbs"
      ["GET", "POST"].each do |verb|
        assert page.has_content?(verb)
      end
      assert page.has_content? "Top Three Referrers"
      ['http://jumpstartlab.com', 'facebook.com'].each do |referrer|
        assert page.has_content?(referrer)
      end
      assert page.has_content? "Three Most Popular User Agents"
      assert page.has_content? ["Chrome, Mac OS X 10.8.2", "Chrome, Mac OS X 10.11.3"]
    end
  end

  def test_displays_url_request_does_not_exitst
    post "/sources", { identifier: "jumpstartlabs",
                       rootUrl:   "http://jumpstartlab.com" }
    post "/sources/jumpstartlabs/data", { payload: payload.to_json }

    visit "/sources/jumpstartlabs/urls/about"

    assert page.has_content? 'The url requested does not exist'
  end
end
