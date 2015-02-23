require './test/test_helper.rb'

module TrafficSpy
  class ApplicationEventDetail < Minitest::Test
    include Rack::Test::Methods
    include Capybara::DSL

    def app
      TrafficSpy::Server
    end

    def setup
      super
      @identifier = Identifier.create(name: 'yahoo', root_url: 'yahoo.com')
      setup_yahoo
      visit('/sources/yahoo/events')
    end

    def test_it_can_view_a_details_page
      click_link_or_button("beginRegistration")
      assert "sources/yahoo/events/beginRegistration", current_path
      assert page.has_content?("Event Details")
    end

    def test_sees_hour_by_hour_breakdown
      click_link_or_button("beginRegistration")
      assert "sources/yahoo/events/beginRegistration", current_path
      assert page.has_content?("Occurrences:")
    end

    def test_we_get_to_error_message_when_no_proper_name
      visit "/sources/yahoo/events/carts"
      assert page.has_content?("No event with the given name has been defined. Try a different one.")
    end

    def setup_yahoo
      @payload_1 = 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 21:38:28 -0700","respondedIn":37,"referredBy":"http://apple.com","requestType":"GET","parameters":["what","huh"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"}'
      @payload_2 = 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 22:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["what","huh"],"eventName": "beginRegistration","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"500","resolutionHeight":"700","ip":"63.29.38.214"}'
      @payload_3 = 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 12:38:28 -0700","respondedIn":200,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Windows%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"}'
      @payload_4 = 'payload={"url":"http://yahoo.com/not_news","requestedAt":"2013-01-14 21:38:28 -0700","respondedIn":123,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "beginRegistration","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"72.29.38.214"}'
      @payload_5 = 'payload={"url":"http://yahoo.com/not_news","requestedAt":"2015-01-14 21:38:28 -0700","respondedIn":130,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "beginRegistration","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"100.100.38.214"}'
      @payload_6 = 'payload={"url":"http://yahoo.com/chat_room","requestedAt":"2015-01-14 21:38:28 -0700","respondedIn":10,"referredBy":"http://jumpstartlab.com","requestType":"POST","parameters":["slow"],"eventName": "chatting","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Firefox/24.0.1309.0 Safari/537.17","resolutionWidth":"1000","resolutionHeight":"1000","ip":"88.88.88.888"}'
      post '/sources/yahoo/data', @payload_1
      post '/sources/yahoo/data', @payload_2
      post '/sources/yahoo/data', @payload_3
      post '/sources/yahoo/data', @payload_4
      post '/sources/yahoo/data', @payload_5
      post '/sources/yahoo/data', @payload_6
    end
  end
end
