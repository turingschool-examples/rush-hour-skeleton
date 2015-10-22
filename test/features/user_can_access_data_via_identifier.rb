require './test/test_helper'

class IdentifierViewTest < FeatureTest
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_user_can_view_their_own_identifier_page
    visit '/sources/jumpstartlab'

    assert page.has_content?("Most Requested URLS to Least Requested URLS") #url
    assert page.has_content?("Web Browser Breakdown") #user_agent
    assert page.has_content?("OS Breakdown") #user_agent
    assert page.has_content?("Screen Resolution") # resolution_width, resolution_height
    assert page.has_content?("Longest to Shortest Response Times") # responded_in
    assert page.has_content?("Hyperlinks of each URL") 
    assert page.has_content?("Hyperlink to view event data")
  end


end
