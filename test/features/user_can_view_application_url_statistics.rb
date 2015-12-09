require_relative "../test_helper"

class UserCanViewApplicationURLStatisticsTest < FeatureTest
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
