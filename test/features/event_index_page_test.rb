require 'minitest/autorun'
require 'minitest/pride'
require_relative '../test_helper'

class EventIndexPageTest < FeatureTest
  attr_reader :payload, :payload2, :payload3, :payload5, :payload4, :payload6

  def setup
    @payload = '{
      "url":"http://labs.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"2",
      "resolutionHeight":"4",
      "ip":"63.29.38.211"}'
    @payload2 = '{
      "url":"http://google.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"2",
      "resolutionHeight":"4",
      "ip":"63.29.38.211"}'
    @payload3 = '{
      "url":"http://google.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":44,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLoginyay",
      "userAgent":"Mozilla/5.0 (Windows NT 6.3; rv:36.0) Gecko/20100101 Firefox/36.0",
      "resolutionWidth":"1234",
      "resolutionHeight":"5678",
      "ip":"63.29.38.211"}'
    @payload4 = '{
      "url":"http://goo.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":44,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLoginyay",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"}'
    @payload5 = '{
      "url":"http://apple.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":44,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLoginyay",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"}'
    @payload6 = '{
      "url":"http://goo.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":55,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLoginyay",
      "userAgent":"Mozilla/5.0 (Windows NT 6.3; rv:36.0) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"}'
  end

  def test_can_navigate_to_event_details_page
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    visit '/sources/jumpstartlab/events'
    click_link_or_button('socialLogin')
    assert_equal "/sources/jumpstartlab/events/socialLogin", current_path
  end

  def test_can_display_error_page_when_no_events_exist
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    visit '/sources/jumpstartlab/events'
    # save_and_open_page
    assert page.has_content?('Sorry, no events have been defined.')
  end

end
