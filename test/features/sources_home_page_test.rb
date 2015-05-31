require 'minitest/autorun'
require 'minitest/pride'
require_relative '../test_helper'

class SourceHomePage < FeatureTest
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
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
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
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
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
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
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
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
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
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
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
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"}'
  end

  def test_can_view_data
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    visit '/sources/jumpstartlab'
    # save_and_open_page
    assert page.has_content?('jumpstartlab')

    #
    # fill_in "skill[title]", with: "skill1"
    # fill_in "skill[description]", with: "juggling"
    # click_button "submit"
    # assert_equal "/skills", current_path
    # assert page.has_content?("skill1")
  end

  def test_can_display_most_hit_url
    # urls = []
    # Payload.where(source_id: 1).find_each do |payload|
    #   urls << payload.url
    # end
    # or within source... payloads.order
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    post '/sources/jumpstartlab/data', "payload" => payload2
    post '/sources/jumpstartlab/data', "payload" => payload3
    post '/sources/jumpstartlab/data', "payload" => payload4
    post '/sources/jumpstartlab/data', "payload" => payload5
    post '/sources/jumpstartlab/data', "payload" => payload6
    visit '/sources/jumpstartlab'
    # save_and_open_page
    assert page.has_content?('http://labs.com/blog')
  end

  def test_can_display_longest_to_shortest_average_response_times
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    post '/sources/jumpstartlab/data', "payload" => payload2
    post '/sources/jumpstartlab/data', "payload" => payload3
    post '/sources/jumpstartlab/data', "payload" => payload4
    post '/sources/jumpstartlab/data', "payload" => payload5
    post '/sources/jumpstartlab/data', "payload" => payload6
    visit '/sources/jumpstartlab'
    # save_and_open_page
    assert page.has_content?('Average Response Times')
    assert page.has_content?('Average response time of')
  end

  def test_can_display_resolution_info
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    post '/sources/jumpstartlab/data', "payload" => payload2
    post '/sources/jumpstartlab/data', "payload" => payload3
    post '/sources/jumpstartlab/data', "payload" => payload4
    post '/sources/jumpstartlab/data', "payload" => payload5
    post '/sources/jumpstartlab/data', "payload" => payload6
    visit '/sources/jumpstartlab'
    save_and_open_page
    assert page.has_content?('Resolution')
    assert page.has_content?('1280')
  end

  def test_it_returns_error_if_no_identifier_found
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    visit '/sources/notarealidentifier'

    refute page.has_content?('notarealidentifier')
    assert page.has_content?('The identifier you entered cannot be found')
  end

end
