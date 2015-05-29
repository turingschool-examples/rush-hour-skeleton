require_relative '../test_helper'
require 'pry'

class PayloadAcceptanceTest < ControllerTest

  # def test_can_accept_proper_payload
  #   post '/sources/jumpstartlab/data', {
  #     "url":"http://jumpstartlab.com/blog",
  #     "requestedAt":"2013-02-16 21:38:28 -0700",
  #     "respondedIn":37,
  #     "referredBy":"http://jumpstartlab.com",
  #     "requestType":"GET",
  #     "parameters":[],
  #     "eventName": "socialLogin",
  #     "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
  #     "resolutionWidth":"1920",
  #     "resolutionHeight":"1280",
  #     "ip":"63.29.38.211"
  #   }
  #   assert_equal 200, last_response.status
  # end

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

  def test_can_accept_proper_payload
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    assert_equal 200, last_response.status
  end

  def test_can_return_400_error_if_no_payload
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => nil.to_json
    assert_equal 400, last_response.status
    assert_equal "your payload is missing data ya ding dong", last_response.body
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload"
    assert_equal 400, last_response.status
    assert_equal "your payload is missing data ya ding dong", last_response.body
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => ""
    assert_equal 400, last_response.status
    assert_equal "your payload is missing data ya ding dong", last_response.body
  end

  def test_can_return_403_error_if_payload_already_exists
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    assert_equal 200, last_response.status
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    assert_equal 403, last_response.status
    assert_equal "payload already exists", last_response.body
    post '/sources' , { "identifier" => "google", "rootUrl" => "http://google.com" }
    post '/sources/google/data', "payload" => payload2
    assert_equal 200, last_response.status
    post '/sources' , { "identifier" => "google", "rootUrl" => "http://google.com" }
    post '/sources/google/data', "payload" => payload2
    assert_equal 403, last_response.status
    assert_equal "payload already exists", last_response.body
  end

  def test_can_return_403_if_url_is_not_valid
    post '/sources/jumpstartlab/data', "payload" => payload
    assert_equal 400, last_response.status
    assert_equal "you never registered your url ya ding dong", last_response.body
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', "payload" => payload
    assert_equal 200, last_response.status
  end
end
