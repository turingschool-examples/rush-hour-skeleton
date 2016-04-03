
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

#     within('#analytics') do
#       assert page.has_content?("Average Response time across all requests: 25.0")
#       assert page.has_content?("Max Response time across all requests: 40")
#       assert page.has_content?("Min Response time across all requests: 10")
#       assert page.has_content?("Most frequent request type: GET")
#       assert page.has_content?("List of all HTTP verbs used: [\"GET\", \"POST\"]")
#       assert page.has_content?("List of URLs listed from most requested to least requested: \"http://turing.io\"")
#       assert page.has_content?("Web browser breakdown across all requests: [\"Mozilla\", \"Opera\", \"Chrome\"]")
#       assert page.has_content?("OS breakdown across all requests: [\"Windows\", \"Webkit\", \"Macintosh\"]")
#       assert page.has_content?("Screen Resolutions across all requests (resolutionWidth x resolutionHeight): [\"2560x1440\", \"1920x1280\"]")
#     end
   end
end

