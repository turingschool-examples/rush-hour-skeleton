require 'minitest/autorun'
require 'minitest/pride'
require_relative '../test_helper'

class SourceHomePage < FeatureTest
  attr_reader :payload, :payload2

  def setup
    @payload = {
      "url":"http://labs.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"}.to_json
    @payload2 = {
      "url":"http://google.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"}.to_json
  end

  def test_can_view_data
    skip
    visit '/sources/:identifier'
    assert page.has_content?(':identifier')

    #
    # fill_in "skill[title]", with: "skill1"
    # fill_in "skill[description]", with: "juggling"
    # click_button "submit"
    # assert_equal "/skills", current_path
    # assert page.has_content?("skill1")
  end

  def test_can_display_most_hit_url
    skip
# urls = []
    # Payload.where(source_id: 1).find_each do |payload|
    #   urls << payload.url
    # end

    # or within source... payloads.order
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    visit '/sources/:identifier'
    assert page.has_content?('http://labs.com/blog')
  end


end
