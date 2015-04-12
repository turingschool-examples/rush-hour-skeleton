require './test/test_helper'
module TrafficSpy
  class UrlsViewTest < FeatureTest

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


    def test_it_shows_longest_shortest_and_average_response_times
      visit '/sources/yahoo/urls/weather'
      assert '/sources/yahoo/urls/weather'
      assert page.has_content?('Longest Response Time')
      assert page.has_content?('Shortest Response Time')
      assert page.has_content?('Average Response Time')
    end


    def teardown
      DatabaseCleaner.clean
    end
  end
end
