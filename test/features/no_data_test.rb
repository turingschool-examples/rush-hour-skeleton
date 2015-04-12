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


    def test_no_events_page
      visit '/sources/boogiewoogie/events'
      assert_equal '/sources/boogiewoogie/events', current_path
      assert page.has_content?("There are no events yet for ")
    end

    def test_no_url
      visit '/sources/jumpstartlab/urls/IDONTEXIST'
      assert_equal '/sources/jumpstartlab/urls/IDONTEXIST', current_path
      assert page.has_content?("Unidentified URL")
    end

    def test_no_identifier
      visit '/sources/jumpstartlabs'
      assert_equal '/sources/jumpstartlabs', current_path
      save_and_open_page
      assert page.has_content?("Identity Not Found")
    end

    def teardown
      DatabaseCleaner.clean
    end

  end
end