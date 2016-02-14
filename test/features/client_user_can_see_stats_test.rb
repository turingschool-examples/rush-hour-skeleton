require_relative '../test_helper'

class ClientStatsTest < FeatureTest
  include TestHelpers

  # def payload_one
  #   {
  #     "payload"=>
  #     "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  #   }
  # end
  #
  # def payload_two
  #   {
  #     "payload"=>
  #     "{\"url\":\"http://jumpstartlab.com/tutorials\",\"requestedAt\":\"2013-02-17 09:38:28 -0700\",\"respondedIn\":27,\"referredBy\":\"http://jumpstartlab.com/blog\",\"requestType\":\"POST\",\"parameters\":[\"email\"],\"eventName\":\"socialLogin\",\"beginRegistration\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"800\",\"resolutionHeight\":\"600\",\"ip\":\"64.30.39.212\"}"
  #   }
  # end

  def test_client_can_see_own_page
    # Client.create(identifier: "google", root_url: "http://google.com")
    # binding.pry
    create_payload_1
#   when a registered user visits it's homepage
    visit '/sources/jumpstartlab'
#   then I should see stats for my web pages
    assert_equal '/sources/jumpstartlab', current_path
    within('.client-stats') do
      assert page.has_content? 'Average Response Time'
      assert page.has_content? 'Max Response Time'
      assert page.has_content? 'Min Response Time'
      assert page.has_content? 'Most Frequent Request Type'
      assert page.has_content? 'HTTP verbs used on your sites'
      assert page.has_content? 'URLs visited from most to least'
      assert page.has_content? 'Web Browser Breakdown'
      assert page.has_content? 'Operating System Breakdown'
      assert page.has_content? 'Screen Resolution Breakdown'
    end
  end
end
