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
      TestData.payloads.each do |payload|
        client = Client.all.first.identifier
        PayloadValidator.validate(payload["payload"], client)
      end
    end

    def teardown
      DatabaseCleaner.clean
    end

    def test_user_can_see_the_page_title
      visit '/sources/jumpstartlab/events'
      assert_equal '/sources/jumpstartlab/events', current_path
      # assert page.has_content?('Events Index')
      save_and_open_page
    end

    # def test_user_can_see_the_page_title
    #   visit '/sources/jumpstartlab/events'
    #   assert page.has_content?('Events Index')
    #   assert page.has_content?("socialLogin")
    # end

  end
end