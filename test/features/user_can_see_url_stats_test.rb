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
      assert page.has_content?('200ms')
      assert page.has_content?('Shortest Response Time')
      assert page.has_content?('37ms')
      assert page.has_content?('Average Response Time')
      assert page.has_content?('91ms')
    end

    def test_it_shows_the_http_verbs_used
      visit '/sources/yahoo/urls/weather'
      assert '/sources/yahoo/urls/weather'
      assert page.has_content?('GET')
    end

    def test_it_shows_most_popular_referers
      visit '/sources/yahoo/urls/weather'
      assert '/sources/yahoo/urls/weather'
      assert page.has_content?('http://apple.com')
    end

    def test_it_shows_most_popular_user_agents
      visit '/sources/yahoo/urls/weather'
      assert '/sources/yahoo/urls/weather'
      save_and_open_page
      assert page.has_content?('Mozilla/5.0 [(]Macintosh%3B Intel Mac OS X 10_8_2)')
    end

    def teardown
      DatabaseCleaner.clean
    end
  end
end
