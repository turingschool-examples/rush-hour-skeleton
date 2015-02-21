require './test/test_helper.rb'

module TrafficSpy
  class ApplicationEventsIndexTest < Minitest::Test
    include Rack::Test::Methods
    include Capybara::DSL

    def app
      TrafficSpy::Server
    end

    # def setup
    #   post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    #   post '/sources', 'payload={
    #               "url":"http://jumpstartlab.com/blog",
    #               "requestedAt":"2013-02-16 21:38:28 -0700",
    #               "respondedIn":37,
    #               "referredBy":"http://jumpstartlab.com",
    #               "requestType":"GET",
    #               "parameters":["article title", "article body"],
    #               "eventName": "socialLogin1",
    #               "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    #               "resolutionWidth":"1920",
    #               "resolutionHeight":"1280",
    #               "ip":"63.29.38.211"}'
    #   @payload2 = 'payload={
    #               "url":"http://jumpstartlab.com/blog",
    #               "requestedAt":"2014-02-16 21:38:28 -0700",
    #               "respondedIn":37,
    #               "referredBy":"http://jumpstartlab.com",
    #               "requestType":"GET",
    #               "parameters":["article title", "article body"],
    #               "eventName": "socialLogin",
    #               "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    #               "resolutionWidth":"1920",
    #               "resolutionHeight":"1280",
    #               "ip":"63.29.38.211"}'
    #   # post '/sources/jumpstartlab/data', @payload1
    #   post '/sources/jumpstartlab/data', @payload2
    # end

    # def setup
    #   super
    #   @identifier = Identifier.create(name: 'jumpstartlab', root_url: 'jumpstartlab.com')
    #   visit '/sources/jumpstartlab'
    # end

    def test_page_has_header
      visit('/sources/jumpstartlab/events')
      assert page.has_content?("Jumpstartlab Events")
    end

    def test_page_lacks_nonsense
      visit('/sources/jumpstartlab/events')
      refute page.has_content?("baba ghanoush")
    end

    def test_detects_css
      visit '/sources/jumpstartlab/events'
      assert_equal '/sources/jumpstartlab/events', current_path
      assert page.has_css?('.event_stats')
      within('.event_stats') do
        assert page.has_content?("Most Received Event")
      end
    end
    # As a CLIENT, when events have been defined, I can see most
    # received event to least received event.

    def test_case_name

    end

# I can also see hyperlinks of each event to view event specific data
    def test_presents_hyperlinks_of_event_to_view_specific_data
      skip
      # within whatever nav bar, see hyperlinks
    end

    def test_can_click_each_hyperlink
      skip

    end

#
# I can also see when no events have been defined:
#
# I can also see a message that no events have been defined




  end
end
