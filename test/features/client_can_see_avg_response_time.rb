require_relative '../test_helper'

class ClientCanSeeAvgResponseTimeTest < FeatureTest
  include TestHelpers
  include Rack::Test::Methods

  def test_client_can_see_avg_resonse_time
    client = Client.create(identifier: "jumpstartlabs",
                           root_url: "http://www.jumpstartlabs.com")
    client.payload_requests.create(requested_at: '2013-02-16 21:38:28 -0700',
                                   responded_in: 45,
                                   event_name: "google",
                                   url_request_id: UrlRequest.create(url: "http://www.jumpstartlabs.com/blog", parameters: '[]').id,
                                   verb_id: Verb.create(request_type: "GET").id,
                                   referrer_id: Referrer.create(referred_by: "jumpstartlabs").id,
                                   user_agent_id: UserAgent.create(browser: "Chrome", os: "OSX").id,
                                   resolution_id: Resolution.create(resolution_width: '1920', resolution_height: '1080').id)

    url = visit "/sources/#{client.identifier}/urls"

    click_link("http://www.jumpstartlabs.com/blog")

    assert_equal '/sources/jumpstartlabs/urls/blog', current_path
    within 'h1' do
      assert page.has_content? "Url Statistics"
    end
    within '#max' do
      assert page.has_content? "Maximum Response Time"
    end
    within '#max-time' do
      assert page.has_content? "45"
    end
  end
end
