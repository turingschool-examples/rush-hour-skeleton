require './test/test_helper'

module TrafficSpy
  class EventDetailsTest < FeatureTest
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

    def teardown
      DatabaseCleaner.clean
    end

    def test_user_can_see_longest_response_time_for_the_url 
      visit '/sources/yahoo/events/socialLogin'
      assert_equal '/sources/yahoo/events/socialLogin', current_path
      save_and_open_page
      assert page.has_content?("12")
      assert page.has_content?("9 PM")
    end

  # As a user
  # When i visit "/sources/identifier/(some_url)" 
  # I should see longest response time for that URL

  end
end