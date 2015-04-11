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
      visit '/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path
      assert page.has_content?('jumpstartlab.com/blog')
    end

    def test_user_can_see_browsers_used_to_vistit_site
      visit '/sources/yahoo'
      assert_equal '/sources/yahoo', current_path
      assert page.has_content?('Chrome')
    end

    def test_user_can_see_OS_used_to_visit_site
      visit '/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path
      assert page.has_content?('OS X 10.8.2')
    end

    def test_user_can_see_screen_resolutions_used_to_visit_site
      visit '/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path
      assert page.has_content?('1280 x 1920')
    end

    def test_user_can_see_longest_to_shortest_average_response_time_per_url
      visit'/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path
      assert page.has_content?('http://jumpstartlab.com/blog - 37ms')
    end

    def test_user_can_click_url_and_be_sent_to_url_specific_page
      visit'/sources/yahoo'
      assert_equal '/sources/yahoo', current_path
      assert page.has_content?('http://yahoo.com/weather')
      click_link_or_button("http://yahoo.com/weather")
      save_and_open_page
      assert_equal '/sources/yahoo/urls/weather', current_path
    end
  end
end
