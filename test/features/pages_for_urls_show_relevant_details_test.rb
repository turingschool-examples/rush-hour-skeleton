require './test/test_helper'

class UrlSiteTest < FeatureTest
  def test_invalid_applicaitons_dont_exist
    visit '/sources/test/urls/test'

    assert page.has_content?("Identifier does not exist")
  end

  def test_invalid_urls_dont_exist
    Client.create({'identifier'=>'jumpstartlab', 'root_url'=>'http://jumpstartlab.com'})

    visit '/sources/jumpstartlab/urls/test'

    assert page.has_content?("No Payload data")
  end

  def test_url_pages_contain_relevant_details
    Client.create({'identifier'=>'jumpstartlab', 'root_url'=>'http://jumpstartlab.com'})
    payload = {
      url: "http://jumpstartlab.com/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by: "http://jumpstartlab.com",
      request_type: "GET",
      browser: "Chrome",
      operating_system: "OS X 10.8.2",
      resolution_width: "1920",
      resolution_height: "1280",
      ip: "63.29.38.211"
    }

    PayloadPopulator.populate(payload, "jumpstartlab").save

    visit '/sources/jumpstartlab/urls/blog'

    assert page.has_content?("Analytics for http://jumpstartlab.com/blog")

    assert page.has_content?("Response Time Statistics")
    assert page.has_content?("Site Information")
    assert page.has_content?("Referrals")
    assert page.has_content?("System Information")
  end

  def test_url_site_links_back_to_application_site
    Client.create({'identifier'=>'jumpstartlab', 'root_url'=>'http://jumpstartlab.com'})
    payload = {
      url: "http://jumpstartlab.com/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by: "http://jumpstartlab.com",
      request_type: "GET",
      browser: "Chrome",
      operating_system: "OS X 10.8.2",
      resolution_width: "1920",
      resolution_height: "1280",
      ip: "63.29.38.211"
    }

    PayloadPopulator.populate(payload, "jumpstartlab").save

    visit '/sources/jumpstartlab/urls/blog'

    assert page.has_content?("Link to Source")
    page.click_link("Link to Source")
    assert_equal '/sources/jumpstartlab', current_path
  end
end
