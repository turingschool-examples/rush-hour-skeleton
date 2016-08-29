require './test/test_helper'

class IdentifierTest < FeatureTest
  def test_unregistered_applications_dont_exist
    visit '/sources/test'
    assert page.has_content?("Identifier does not exist")
  end

  def test_pages_with_no_payloads_dont_exist
    Client.create({'identifier'=>'jumpstartlab', 'root_url'=>'http://jumpstartlab.com'})

    visit '/sources/jumpstartlab'
    assert page.has_content?("No Payload data")
  end

  def test_identifier_pages_describe_applications
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

    visit '/sources/jumpstartlab'
    assert page.has_content?("Analytics for: jumpstartlab")
    assert page.has_content?("Response Time Statistics")
    assert page.has_content?("Site Information")
    assert page.has_content?("System Information")
  end

  def test_users_can_return_to_list_of_applications
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

    visit '/sources/jumpstartlab'
    first(".container").click_link("Home")

    assert_equal '/sources', current_path
    assert page.has_content?("Welcome")
    assert page.has_content?("Jumpstartlab statistics")

    page.click_link("Jumpstartlab statistics")

    assert_equal '/sources/jumpstartlab', current_path
    assert page.has_content?("Analytics for: jumpstartlab")
  end

  def test_users_can_navigate_to_details_page
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

    visit '/sources/jumpstartlab'
    assert page.has_content?("jumpstartlab.com/blog")
    page.click_link("jumpstartlab.com/blog")
    assert_equal "/sources/jumpstartlab/urls/blog", current_path
  end
end
