require_relative '../test_helper'

class URLPageTest < FeatureTest
  def test_when_url_link_is_clicked_it_takes_you_to_url_stats_page
    create_data

    visit '/sources/jumpstartlab'
    first(:link, "http://jumpstartlab.com/blog").click
    assert_equal "/sources/jumpstartlab/urls/blog", current_path
    assert page.has_content?("URL Statistics for http://jumpstartlab.com/blog")
  end

  def test_when_url_link_doesnt_exist_it_sends_back_to_home_with_error_message
    create_data

    visit '/sources/jumpstartlab/urls/asdf'
    assert_equal "/", current_path
    assert page.has_content?("ERROR: URL has not been requested.")
  end

  def test_page_displays_longest_response_time
    create_data
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2012-02-16 21:38:28 -0701", responded_in: 13})

    visit '/sources/jumpstartlab/urls/blog'
    assert page.has_content?("Longest Response Time")
    assert page.has_content?("13")
  end

  def test_page_displays_shortest_response_time
    create_data
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2012-02-16 21:38:28 -0701", responded_in: 13})

    visit '/sources/jumpstartlab/urls/blog'
    assert page.has_content?("Shortest Response Time")
    assert page.has_content?("10")
  end

  def test_page_displays_http_routes_used
    create_data
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2012-02-16 21:38:28 -0701", responded_in: 13, request_type: "GET"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2012-02-16 21:38:28 -0702", responded_in: 13, request_type: "POST"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2022-02-16 21:38:28 -0701", responded_in: 13, request_type: "GET"})

    visit '/sources/jumpstartlab/urls/blog'
    assert page.has_content?("HTTP Routes Used")
    assert page.has_content?("GET")
    assert page.has_content?("POST")
  end

  def test_page_displays_most_popular_referrer
    create_data
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2012-02-16 21:38:28 -0701", responded_in: 13, request_type: "GET", referred_by: "asdf"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2014-02-16 21:38:28 -0702", responded_in: 13, request_type: "POST", referred_by: "asdf"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2022-02-16 21:37:28 -0701", responded_in: 13, request_type: "GET", referred_by: "haha"})

    visit '/sources/jumpstartlab/urls/blog'
    assert page.has_content?("Most Popular Referrer")
    assert page.has_content?("asdf")
  end
end
