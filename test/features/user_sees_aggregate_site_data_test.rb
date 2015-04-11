require './test/test_helper'
module TrafficSpy
  class AggregateDataTest < FeatureTest

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

    def test_user_can_see_most_requested_to_least_requested_urls
      binding.pry
      visit '/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path
      save_and_open_page
      assert page.has_content?('jumpstartlab.com/blog')
    end

  end
end
