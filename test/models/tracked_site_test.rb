require './test/test_helper'

module TrafficSpy
  class TrackedSiteTest < Minitest::Test 

    def setup
      DatabaseCleaner.start
      TestData.feature_tests.each do |payload|
        PayloadValidator.validate(payload[0]["payload"], payload[1])
      end
    end

    def test_it_can_find_average_response_time
      site = TrackedSite.find(3)
      result = site.average_response_time
      assert_equal 315, result
    end

    def test_it_returns_response_times
      site = TrackedSite.find(3)
      result = site.payloads_response_time.first.responded_in
      assert_equal 90, result
    end

    def test_it_returns_longest_response_time
      site = TrackedSite.find(3)
      result = site.longest_response_time
      assert_equal 540, result
    end

    def test_it_returns_shortest_response_time
      site = TrackedSite.find(3)
      result = site.shortest_response_time
      assert_equal 90, result
    end

    def test_it_returns_verbs
      site = TrackedSite.find(3)
      result = site.http_verbs
      assert_equal ["POST"], result
    end 

    def test_it_returns_referers
      site = TrackedSite.find(3)
      result = site.referers
      expected = ["http://apple.com", "http://jumpstartlab.com"]
      assert_equal expected, result
    end      

    def test_it_returns_referers
      site = TrackedSite.find(3)
      result = site.ordered_most_popular_user_agents
      expected = {1=>1, 4=>1}
      assert_equal expected, result
    end 

    def test_it_returns_most_to_least_referers
      site = TrackedSite.find(3)
      result = site.ordered_most_to_least_agents
      expected = "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"
      assert_equal expected, result.first
    end

    def teardown
      DatabaseCleaner.clean
    end
  end
end



