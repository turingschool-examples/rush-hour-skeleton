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
end
