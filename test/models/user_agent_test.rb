require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelper

  def test_it_can_save_user_agent
    UserAgent.create(browser: "Chrome 24.0.1309",
                          os: "Mac OS X 10.8.2")

    user_agent = UserAgent.first

    assert_equal "Chrome 24.0.1309", user_agent.browser
    assert_equal "Mac OS X 10.8.2", user_agent.os
  end

  def test_it_doesnt_save_user_agent_with_invalid_browser
    UserAgent.create(os: "Mac OS X 10.8.2")

    assert_equal [], UserAgent.all.to_a
  end

  def test_it_doesnt_save_user_agent_with_invalid_os
    UserAgent.create(browser: "Chrome 24.0.1309")

    assert_equal [], UserAgent.all.to_a
  end

  def test_it_returns_web_browsers
    skip
    ua1 = UserAgent.create(browser: "Chrome 24.0.1309",
                           os: "Mac OS X 10.8.2")

    ua2 = UserAgent.create(browser: "IE 9.0",
                           os: "Mac OS X 10.8.2")

    client = create_client
    # probably have to take these out of user agent
    client.payload_requests.joins(:user_agent).group(:browser).count
    client.user_agents.group(:browser).distinct.count

    create_payload_requests(ua1.id, ua2.id, client.id)
    require 'pry'; binding.pry
    assert_equal ["IE 9.0", "Chrome 24.0.1309"], client.user_agents.web_browsers
  end

  def test_it_returns_operating_systems
    skip
    ua1 = UserAgent.create(browser: "Chrome 24.0.1309",
                          os: "Windows 10")

    ua2 = UserAgent.create(browser: "IE 9.0",
                          os: "Mac OS X 10.8.2")

    create_payload_requests(ua1.id, ua2.id)

    assert_equal ["Mac OS X 10.8.2", "Windows 10"], ua1.all_operating_systems
  end

  def create_client
    Client.create(
      identifier: "jumpstartlabs",
      rootUrl:    "www.jumpstartlabs.com")
  end

  def create_payload_requests(ua1_id, ua2_id, client_id)
    PayloadRequest.create(
      url_id:          1,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   100,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   ua1_id,
      resolution_id:   1,
      ip_id:           1,
      client_id:       client_id, )
    PayloadRequest.create(
      url_id:          1,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   300,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   ua1_id,
      resolution_id:   1,
      ip_id:           1,
      client_id:       client_id )
    PayloadRequest.create(
      url_id:          1,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   300,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   ua2_id,
      resolution_id:   1,
      ip_id:           1,
      client_id:       client_id )
  end

end
