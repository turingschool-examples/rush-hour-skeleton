require_relative "../test_helper"

class UserCanViewApplicationURLStatisticsTest < FeatureTest
  def register_turing_and_send_multiple_payloads
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 80,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Safari",
      resolution: {width: "600", height: "800"},
      ip_address:"63.29.38.211"
    }

    payload_data_3 = {
      relative_path: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 50,
      referred_by:"http://turing.io",
      request_type:"POST",
      event: "socialLogin",
      operating_system: "Windows",
      browser: "IE10",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_4 = {
      relative_path: "/team",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 40,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Windows",
      browser: "Chrome",
      resolution: {width: "1920", height: "1080"},
      ip_address:"63.29.38.211"
    }

    payload_data_5 = {
      relative_path: "/team",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 41,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_6 = {
      relative_path: "/about",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 5,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Mozilla",
      resolution: {width: "1366", height: "768"},
      ip_address:"63.29.38.211"
    }

    payloads = [payload_data_1, payload_data_2, payload_data_3,
                payload_data_4, payload_data_5, payload_data_6]

    app = TrafficSpy::Application.find_by(identifier: "turing")

    payloads.each do |data|
      app.payloads.create(data)
    end
  end

  def test_user_can_view_statistics_for_a_url_blog
    register_turing_and_send_multiple_payloads

    url = '/blog'
    visit "/sources/turing/urls#{url}"
    # save_and_open_page

    assert page.has_content?("turing")
    assert page.has_content?("blog")
    assert page.has_content?("Longest Response Time: 80")
    assert page.has_content?("Shortest Response Time: 37")
    assert page.has_content?("Average Response Time: 55.67")
    assert page.has_content?("HTTP Verbs:")
    assert page.has_content?("GET (2)")
    assert page.has_content?("POST (1)")
    assert page.has_content?("Most Popular Referrers:")
    assert page.has_content?("http://turing.io (3)")
    assert page.has_content?("Most Popular Operating Systems:")
    assert page.has_content?("Macintosh (2)")
    assert page.has_content?("Windows (1)")
    assert page.has_content?("Most Popular Browsers:")
    assert page.has_content?("Chrome (1)")
    assert page.has_content?("Safari (1)")
    assert page.has_content?("IE10 (1)")
  end

  def test_user_can_view_statistics_for_a_url_team
    register_turing_and_send_multiple_payloads

    url = '/team'
    visit "/sources/turing/urls#{url}"
    # save_and_open_page

    assert page.has_content?("turing")
    assert page.has_content?("team")
    assert page.has_content?("Longest Response Time: 41")
    assert page.has_content?("Shortest Response Time: 40")
    assert page.has_content?("Average Response Time: 40.5")
    assert page.has_content?("HTTP Verbs:")
    assert page.has_content?("GET (2)")
    assert page.has_content?("Most Popular Referrers:")
    assert page.has_content?("http://turing.io (2)")
    assert page.has_content?("Most Popular Operating Systems:")
    assert page.has_content?("Windows (1)")
    assert page.has_content?("Macintosh (1)")
    assert page.has_content?("Most Popular Browsers:")
    assert page.has_content?("Chrome (2)")
  end

  def test_user_sees_error_message_when_identifier_not_registered
    register_turing_and_send_multiple_payloads

    url = '/beth'
    visit "/sources/turing/urls#{url}"
    # save_and_open_page

    assert page.has_content?("turing")
    assert page.has_content?("beth")
    assert page.has_content?("URL has not been requested.")

  end
end
