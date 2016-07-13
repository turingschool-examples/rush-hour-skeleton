require_relative '../test_helper'
class ClientCanViewSpecificPathData < FeatureTest
  include TestHelpers

  def setup
    client = Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
  end

  def test_client_can_view_their_name_in_header
    visit '/sources/jumpstartlab/urls/blog'

    assert page.has_content?("jumpstartlab")
  end

  def test_client_can_specific_path_data_on_page
    create_multiple_payloads(3)
    visit '/sources/jumpstartlab/'

    assert has_content?("Average Response Time")
    assert has_content?("Minimum Response Time")
    assert has_content?("Maximum Response Time")
    assert has_content?("Verb List for URL")
    assert has_content?("Response Times (Longest to Shortest)")
    assert has_content?("Top Referrers for URL")
    assert has_content?("Top User Agents for URL")
  end
end
