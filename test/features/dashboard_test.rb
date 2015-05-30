require_relative '../test_helper'

class DashboardTest < FeatureTest
  def test_it_loads_dashboard
    Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" })

    visit '/sources/jumpstartlab'
    assert page.has_content?("Site data for jumpstartlab")
  end

  def test_it_redirects_unregistered_source
    visit '/sources/jumpstartlab'
    
    assert page.has_content?("Hello, Traffic Spyer")
    assert page.has_content?("oops")
  end

  def test_it_displays_url
    Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0100"})

    visit '/sources/jumpstartlab'
    assert page.has_content?("http://jumpstartlab.com/blog")
  end

  def test_it_displays_url_in_order_from_most_to_least_requested
    Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" })
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
end
