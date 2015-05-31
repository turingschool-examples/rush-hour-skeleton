require_relative '../test_helper'

class DashboardTest < FeatureTest
  def create_source(identifier)
    Source.create({identifier: identifier, root_url: "http://#{identifier}.com" })
  end

  def json(identifier)
    { :url              => "http://#{identifier}.com/blog",
      :requestedAt      => "2013-02-16 21:38:28 -0700",
      :respondedIn      => 37,
      :referredBy       => "http://#{identifier}.com",
      :requestType      => "GET",
      :parameters       => [],
      :eventName        => "socialLogin",
      :userAgent        => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      :resolutionWidth  => "1920",
      :resolutionHeight => "1280",
      :ip               => "63.29.38.211"
    }.to_json
  end
  
  def create_payload(identifier)
    PayloadCreator.new(json(identifier), identifier)
  end
  
  def test_it_loads_dashboard
    create_source("jumpstartlab")

    visit '/sources/jumpstartlab'
    assert page.has_content?("Site data for jumpstartlab")
  end

  def test_it_redirects_unregistered_source
    visit '/sources/jumpstartlab'
    
    assert page.has_content?("Hello, Traffic Spyer")
    assert page.has_content?("ERROR: Identifier doesn't exist.")
  end

  def test_it_displays_url
    create_source("jumpstartlab")
    create_payload("jumpstartlab")

    visit '/sources/jumpstartlab'
    assert page.has_content?("http://jumpstartlab.com/blog")
  end

  def test_it_displays_url_in_order_from_most_to_least_requested
    create_source("jumpstartlab")
    
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0710"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/asdf", requested_at: "2013-02-16 21:38:28 -0720"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2213-02-16 21:38:28 -0710"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2113-02-16 21:38:28 -0710"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/asdf", requested_at: "2013-02-12 21:38:28 -0720"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/lol", requested_at: "2233-02-16 21:38:28 -0720"})

    visit '/sources/jumpstartlab'
    assert page.has_content?("http://jumpstartlab.com/blog 4")
    assert page.has_content?("http://jumpstartlab.com/asdf 2")
  end

  def test_it_displays_average_response_times_for_urls
    create_source("jumpstartlab")
    
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0701", responded_in: 10})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/asdf", requested_at: "2013-02-16 21:38:28 -0705", responded_in: 5})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/asdf", requested_at: "2013-02-16 21:38:28 -0799", responded_in: 6})

    visit '/sources/jumpstartlab'
    assert page.has_content?("Average Response Times")
    assert page.has_content?("http://jumpstartlab.com/blog 15.0")
    assert page.has_content?("http://jumpstartlab.com/asdf 5.5")
  end

  def test_it_displays_browser_breakdown
    create_source ("jumpstartlab")
    create_payload("jumpstartlab")
    
    visit '/sources/jumpstartlab'
    assert page.has_content?("Browser Breakdown")
    assert page.has_content?("Chrome: 1")
  end
  
  def test_it_displays_platform_breakdown
    create_source ("jumpstartlab")
    create_payload("jumpstartlab")

    visit '/sources/jumpstartlab'
    assert page.has_content?("Platform Breakdown")
    assert page.has_content?("Macintosh: 1")
  end

  def test_it_has_hyperlink_for_events
    create_source ("jumpstartlab")
    create_payload("jumpstartlab")

    visit '/sources/jumpstartlab'
    assert page.has_link?("View events")
  end
end
