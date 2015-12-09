require_relative '../test_helper'

class UserCanViewApplicationDetailsTest < FeatureTest
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
      request_type:"GET",
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

  def test_user_can_view_details_for_a_registered_application
    register_turing_and_send_multiple_payloads

    visit '/sources/turing'
    # Then I see the most requested URLS to least requested URLS (url),]
    within 'ol#most_requested_urls li:nth-child(1)' do
      assert page.has_content?('/blog')
      assert page.has_css?("a[href~='/sources/turing/blog']")
      assert page.has_content?(3)
    end

    within 'ol#most_requested_urls li:nth-child(2)' do
      assert page.has_content?('/team')
      assert page.has_css?("a[href~='/sources/turing/team']")
      assert page.has_content?(2)
    end

    within 'ol#most_requested_urls li:nth-child(3)' do
      assert page.has_content?('/about')
      assert page.has_css?("a[href~='/sources/turing/about']")
      assert page.has_content?(1)
    end

    within 'ol#web_browser li:nth-child(1)' do
      assert page.has_content?('Chrome')
      assert page.has_content?(3)
    end

    within 'ol#web_browser li:nth-child(2)' do
      assert page.has_content?('Mozilla')
      assert page.has_content?(1)
    end

    within 'ol#web_browser li:nth-child(3)' do
      assert page.has_content?('Safari')
      assert page.has_content?(1)
    end

    within 'ol#web_browser li:nth-child(4)' do
      assert page.has_content?('IE10')
      assert page.has_content?(1)
    end

    within 'ol#operating_system li:nth-child(1)' do
      assert page.has_content?('Macintosh')
      assert page.has_content?(4)
    end
    # And I see web browser breakdown across all requests (userAgent),
    # And I see OS breakdown across all requests (userAgent),
    # And I see screen Resolution across all requests (resolutionWidth x resolutionHeight),
    # And I see the longest, average response time per URL to shortest, average response time per URL
    # And I see hyperlinks of each url to view url specific data,
    # And I see hyperlink to view aggregate event data

  end

  def test_user_gets_error_if_they_try_to_view_an_unregistered_page
    skip
  end
end
