require './test/test_helper'
module TrafficSpy
  class NoDataTest < FeatureTest

    def app
      TrafficSpy::Server
    end

    def setup
      DatabaseCleaner.start
      TestNoData.clients.each do |client|
        ClientValidator.validate(client)
      end
    end

    def teardown
      DatabaseCleaner.clean
    end

    def test_no_events_page
      visit '/sources/boogiewoogie/events'
      assert_equal '/sources/boogiewoogie/events', current_path
      assert page.has_content?("There are no events yet for ")
    end

  end

end