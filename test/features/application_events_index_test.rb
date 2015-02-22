require './test/test_helper.rb'

module TrafficSpy
  class ApplicationEventsIndexTest < Minitest::Test
    include Rack::Test::Methods
    include Capybara::DSL

    def app
      TrafficSpy::Server
    end

    def setup
      @identifier = Identifier.create(name: 'yahoo', root_url: 'yahoo.com')
      setup_yahoo
      visit('/sources/yahoo/events')
    end

    def test_page_has_header
      assert page.has_content?("yahoo Events")
    end

    def test_page_lacks_nonsense
      refute page.has_content?("baba ghanoush")
    end

    def test_detects_css
      assert_equal '/sources/yahoo/events', current_path
      assert page.has_css?('.event_stats')
      within('.event_stats') do
        assert page.has_content?("Events Ranked By Popularity")
      end
    end

    def test_page_displays_events_according_to_most_received
      assert_equal '/sources/yahoo/events', current_path
      assert page.has_content?("socialLogin")
      assert page.has_content?("chatting")
    end

    # I can also see hyperlinks of each event to view event specific data
    def test_presents_hyperlinks_of_event_to_view_specific_data
      find_link("socialLogin").visible?
      save_and_open_page
      # within whatever nav bar, see hyperlinks
    end

    def test_can_click_each_hyperlink
      skip

    end

#
# I can also see when no events have been defined:
#
# I can also see a message that no events have been defined
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
