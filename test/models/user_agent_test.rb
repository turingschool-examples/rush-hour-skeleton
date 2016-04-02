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
    ua1 = UserAgent.create(browser: "Chrome 24.0.1309",
                           os: "Mac OS X 10.8.2")

    ua2 = UserAgent.create(browser: "IE 9.0",
                           os: "Mac OS X 10.8.2")

    client = create_client
    # probably have to take these out of user agent into payload_requests
    client.payload_requests.joins(:user_agent).group(:browser).count
    client.user_agents.group(:browser).distinct.count

    create_payload_requests(ua1.id, ua2.id, client.id)

    assert client.user_agents.all_web_browsers.include?("IE 9.0")
    assert client.user_agents.all_web_browsers.include?("Chrome 24.0.1309")
  end

  def test_it_returns_web_browsers_associated_with_client_user_agents
    ua1 = UserAgent.create(browser: "Chrome 24.0.1309",
                           os: "Mac OS X 10.8.2")

    ua2 = UserAgent.create(browser: "IE 9.0",
                           os: "Mac OS X 10.8.2")

    client = create_client

    create_payload_requests_2(ua1.id, ua2.id, client.id)

    assert_equal ["Chrome 24.0.1309"], client.user_agents.all_web_browsers
  end

  def test_it_returns_operating_systems
    ua1 = UserAgent.create(browser: "Chrome 24.0.1309",
                          os: "Windows 10")

    ua2 = UserAgent.create(browser: "IE 9.0",
                          os: "Mac OS X 10.8.2")

    client = create_client

    create_payload_requests(ua1.id, ua2.id, client.id)

    assert_equal ["Mac OS X 10.8.2", "Windows 10"], client.user_agents.all_operating_systems.sort

  end

  def test_it_has_many_payload_requests
    agent = create_user_agent

    create_generic_payload_requests

    assert_equal 2, agent.payload_requests.count
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

  def create_payload_requests_2(ua1_id, ua2_id, client_id)
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
      client_id:       100 )
  end

end
