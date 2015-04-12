require './test/test_helper'

module TrafficSpy
  class UrlDataTest < FeatureTest
    include Rack::Test::Methods

    def app
      TrafficSpy::Server
    end

    def setup
      DatabaseCleaner.start
      TestData.clients.each do |client|
        ClientValidator.validate(client)
      end
      TestData.feature_tests.each do |payload|
        PayloadValidator.validate(payload[0]["payload"], payload[1])
      end
    end


    # def test_user_can_see_longest_response_time_for_the_url
    #   visit '/sources/jumpstartlab/urls/jumpstartlab.com/blog'
    #   assert_equal '/sources/jumpstartlab/urls/jumpstartlab.com/blog', current_path
    #   save_and_open_page
    #   assert page.has_content?("Longest response:")
    #   assert page.has_content?("37")
    # end

  # As a user
  # When i visit "/sources/identifier/(some_url)"
  # I should see longest response time for that URL

    def teardown
      DatabaseCleaner.clean
    end
  end
end
