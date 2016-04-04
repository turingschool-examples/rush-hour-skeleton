
require_relative '../test_helper'

class UserCanViewStatsForRelativePath< FeatureTest
  include TestHelpers
  include Rack::Test::Methods

  def test_user_can_follow_and_see_stats_for_relative_path
    register_client
    data_with_relative_path

    path = '/sources/jumpstartlab'
    visit path

    assert_equal path, current_path

    click_link "http://jumpstartlab.com/blog"
    assert_equal "/sources/jumpstartlab/urls/blog", current_path

    within('#analytics') do
      assert page.has_content?("Max Response time: 40")
      assert page.has_content?("Min Response time: 10")
      assert page.has_content?("A list of response times across all requests listed from longest response time to shortest response time: [40, 30, 20, 10]")
      assert page.has_content?("Average Response time for this URL: 25.0")
      assert page.has_content?("HTTP Verb(s) associated with this URL: [\"GET\", \"POST\"]")
      assert page.has_content?("Three most popular referrers: [\"http://amazon.com\", \"http://newegg.com\", \"http://jumpstartlab.com\"]")
      assert page.has_content?("Three most popular user agents: [[\"Mozilla\", \"Windows\"], [\"Chrome\", \"Macintosh\"], [\"Opera\", \"Webkit\"]]")
    end
   end

   def test_displays_error_page_for_bad_url_request
     register_client
     data_with_relative_path

     path = '/sources/jumpstartlab/urls/blarg'
     visit path
     assert_equal path, current_path

     assert page.has_content?("This Url has not been requested")
   end
end
