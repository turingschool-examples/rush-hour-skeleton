require 'minitest/autorun'
require 'minitest/pride'
require_relative '../test_helper'

class UrlStatisticsTest < FeatureTest
  attr_reader :payload, :payload2, :payload3, :payload5, :payload4, :payload6

  def setup
    @payload = '{
      "url":"http://jumpstartlab.com/blog",
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
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"POST",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"2",
      "resolutionHeight":"4",
      "ip":"63.29.38.211"}'
    @payload3 = '{
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":44,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"POST",
      "parameters":[],
      "eventName": "socialLoginyay",
      "userAgent":"Mozilla/5.0 (Windows NT 6.3; rv:36.0) Gecko/20100101 Firefox/36.0",
      "resolutionWidth":"1234",
      "resolutionHeight":"5678",
      "ip":"63.29.38.211"}'
    @payload4 = '{
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":44,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"POST",
      "parameters":[],
      "eventName": "socialLoginyay",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"}'
    @payload5 = '{
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":44,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"POST",
      "parameters":[],
      "eventName": "socialLoginyay",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"}'
    @payload6 = '{
      "url":"http://jumpstartlab.com/blog",
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

  def test_can_view_most_popular_referrers_for_specific_url
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    post '/sources/jumpstartlab/data', "payload" => payload2
    post '/sources/jumpstartlab/data', "payload" => payload3
    post '/sources/jumpstartlab/data', "payload" => payload4
    post '/sources/jumpstartlab/data', "payload" => payload5
    post '/sources/jumpstartlab/data', "payload" => payload6
    visit '/sources/jumpstartlab/urls/blog'
    save_and_open_page
    assert page.has_content?('http://jumpstartlab.com')
  end

  def test_can_view_most_popular_browser_for_specific_url
    # skip
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    post '/sources/jumpstartlab/data', "payload" => payload2
    post '/sources/jumpstartlab/data', "payload" => payload3
    post '/sources/jumpstartlab/data', "payload" => payload4
    post '/sources/jumpstartlab/data', "payload" => payload5
    post '/sources/jumpstartlab/data', "payload" => payload6
    visit '/sources/jumpstartlab/urls/blog'
    # save_and_open_page
    assert page.has_content?('Chrome')
  end

  def test_can_view_most_popular_operating_system_for_specific_url
    # skip
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    post '/sources/jumpstartlab/data', "payload" => payload2
    post '/sources/jumpstartlab/data', "payload" => payload3
    post '/sources/jumpstartlab/data', "payload" => payload4
    post '/sources/jumpstartlab/data', "payload" => payload5
    post '/sources/jumpstartlab/data', "payload" => payload6
    visit '/sources/jumpstartlab/urls/blog'
    # save_and_open_page
    assert page.has_content?('Macintosh')
  end

  def test_can_view_most_popular_http_verb_for_specific_url
    # skip
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    post '/sources/jumpstartlab/data', "payload" => payload2
    post '/sources/jumpstartlab/data', "payload" => payload3
    post '/sources/jumpstartlab/data', "payload" => payload4
    post '/sources/jumpstartlab/data', "payload" => payload5
    post '/sources/jumpstartlab/data', "payload" => payload6
    visit '/sources/jumpstartlab/urls/blog'
    save_and_open_page
    assert page.has_content?('POST')
  end

  def test_can_view_shortest_response_time_for_specific_url
    # skip
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    post '/sources/jumpstartlab/data', "payload" => payload2
    post '/sources/jumpstartlab/data', "payload" => payload3
    post '/sources/jumpstartlab/data', "payload" => payload4
    post '/sources/jumpstartlab/data', "payload" => payload5
    post '/sources/jumpstartlab/data', "payload" => payload6
    visit '/sources/jumpstartlab/urls/blog'
    # save_and_open_page
    assert page.has_content?('POST')
  end

  def test_can_view_longest_response_time_verb_for_specific_url
    # skip
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    post '/sources/jumpstartlab/data', "payload" => payload2
    post '/sources/jumpstartlab/data', "payload" => payload3
    post '/sources/jumpstartlab/data', "payload" => payload4
    post '/sources/jumpstartlab/data', "payload" => payload5
    post '/sources/jumpstartlab/data', "payload" => payload6
    visit '/sources/jumpstartlab/urls/blog'
    # save_and_open_page
    assert page.has_content?('POST')
  end

  def test_can_view_average_response_time_for_specific_url
    # skip
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    post '/sources/jumpstartlab/data', "payload" => payload2
    post '/sources/jumpstartlab/data', "payload" => payload3
    post '/sources/jumpstartlab/data', "payload" => payload4
    post '/sources/jumpstartlab/data', "payload" => payload5
    post '/sources/jumpstartlab/data', "payload" => payload6
    visit '/sources/jumpstartlab/urls/blog'
    # save_and_open_page
    assert page.has_content?('43')
  end

  def test_can_display_url_error_page_when_url_doesnt_exist
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    visit '/sources/jumpstartlab/urls/alskjdf'
    save_and_open_page
    assert page.has_content?('This url has not been requested')
  end
end
