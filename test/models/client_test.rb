require './test/test_helper'

module TrafficSpy
  class ClientTest < Minitest::Test 

    def setup
      DatabaseCleaner.start
      TestData.clients.each do |client|
        ClientValidator.validate(client)
      end
      TestData.feature_tests.each do |payload|
        PayloadValidator.validate(payload[0]["payload"], payload[1])
      end
    end

    def test_it_orders_visited_sites_most_to_least
      client = Client.find(6)
      result = client.ordered_most_to_least_sites
      assert_equal 5, result.count
      assert_equal "http://yahoo.com/weather", result.first
      assert_equal "http://yahoo.com/news", result.last
    end

    def test_it_can_find_browser_information
      client = Client.find(6)
      result = client.browser_information
      assert_equal 5, result.count
      assert_equal "Chrome", result.first
      assert_equal "Chrome", result.last
    end

    def test_it_can_find_resolution_information
      client = Client.find(6)
      result = client.resolution_information
      assert_equal 2, result.count
      assert_equal "600 x 800", result.first
      assert_equal "700 x 500", result.last
    end

    def test_it_can_find_average_response_from_most_to_least
      client = Client.find(6)
      result = client.ordered_most_to_least_avg_response
      assert_equal 2, result.count
      result_1 = {:url=>"http://yahoo.com/weather", :avg_time=>91}
      assert_equal result_1, result.first
      result_2 = {:url=>"http://yahoo.com/news", :avg_time=>123}
      assert_equal result_2, result.last
    end
    
    def test_it_can_most_to_least_events
      client = Client.find(6)
      result = client.ordered_most_to_least_events
      assert_equal 2, result.count
      assert_equal "socialLogin", result.first
      assert_equal "beginRegistration", result.last
    end

    def test_it_can_find_events_by_hour
      client = Client.find(6)
      result = client.events_by_hour(1)
      assert_equal 2, result.count
      assert_equal " 9 PM", result.first
      assert_equal "12 PM", result.last
    end

    def test_it_can_count_events_by_hour
      client = Client.find(6)
      result = client.count_events_by_hour(1)
      assert_equal 2, result.count
      count_data = {:time=>" 9 PM", :count=>1}
      assert_equal count_data, result[0]
    end

    def test_it_can_count_events
      client = Client.find(6)
      result = client.count_events(1)
      assert_equal 2, result
    end

    def teardown
      DatabaseCleaner.clean
    end

  end
end