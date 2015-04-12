require './test/test_helper'
module TrafficSpy
  class EventIndexTest < FeatureTest

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

    def test_user_can_see_the_page_title
      visit '/sources/jumpstartlab/events'
      assert_equal '/sources/jumpstartlab/events', current_path
      assert page.has_content?('Events Ordered')
    end

    def test_user_can_events
      visit '/sources/yahoo/events'
      assert page.has_content?('Events Ordered By Occurrance')
      assert page.has_content?("socialLogin")
      assert page.has_content?("beginRegistration")
      click_link('socialLogin')
      assert_equal '/sources/yahoo/events/socialLogin', current_path
    end

    def teardown
      DatabaseCleaner.clean
    end

  end
end