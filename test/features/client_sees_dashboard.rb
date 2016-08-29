require_relative '../test_helper'

class TestClientSeesDashboard < FeatureTest
  # def test_client_sees_dashboard
  #   Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
  #   payload = PayloadRequest.create(url_id: 1,
  #             requested_at: "date",
  #             responded_in: 34,
  #             referred_by_id: 1,
  #             request_type_id: 1,
  #             u_agent_id: 1,
  #             resolution_id: 1,
  #             ip_id: 1,
  #             client_id: 1
  #             )
  #
  #   visit '/sources/jumpstartlab'
  #
  #   assert page.has_content?("date")
  #   assert page.has_content?("34")
  # end

  def test_client_sees_all_information_on_dashboard
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    Url.create(url: "http://jumpstartlab.com")
    RequestType.create(verb: "GET")
    UAgent.create(agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    Resolution.create(height: 1200, width: 900)
    payload = PayloadRequest.create(url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 1,
              resolution_id: 1,
              ip_id: 1,
              client_id: 1
              )

    visit '/sources/jumpstartlab'

    assert page.has_content?("date")
    assert page.has_content?("34")
    assert page.has_content?("GET")
    assert page.has_content?("http://jumpstartlab.com")
    assert page.has_content?("Chrome")
    assert page.has_content?("Macintosh")
    assert page.has_content?("1200 x 900")
  end
end
