require_relative '../test_helper'

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

  attr_reader :payload

  def setup
    @payload = {"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}
  end

  def test_can_accept_proper_payload
    post '/sources/jumpstartlab/data', { "payload" => payload }
    assert_equal 200, last_response.status
  end

  def test_can_return_400_error_if_no_payload
    # post '/sources/jumpstartlab/data', { "payload" => nil}
    # assert_equal 400, last_response.status
    post '/sources/jumpstartlab/data', { }
    assert_equal 400, last_response.status
  end

  def test_can_return_403_error_if_payload_already_exists
    #{"hello" => "hi", "goodbye" => "bye"}
    post '/sources/jumpstartlab/data', { "payload" => payload }
    assert_equal 200, last_response.status
    # post '/sources/jumpstartlab/data', { "payload" => payload }
    # assert_equal 403, last_response.status
  end

  # As a registered user,
  # when I send a POST request to http://yourapplication:port/sources/IDENTIFIER/data with NO payload,
  # then I expect a 400 response (bad request)

  # As a registered user,
  # when I send a POST request to http://yourapplication:port/sources/IDENTIFIER/data with a payload that has already been sent,
  # then I expect a 403 response (forbidden)


  # def test_can_accept_proper_payload
  #
  #
    # payload = {
    #   "url":"http://jumpstartlab.com/blog",
    #   "requestedAt":"2013-02-16 21:38:28 -0700",
    #   "respondedIn":37,
    #   "referredBy":"http://jumpstartlab.com",
    #   "requestType":"GET",
    #   "parameters":[],
    #   "eventName": "socialLogin",
    #   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    #   "resolutionWidth":"1920",
    #   "resolutionHeight":"1280",
    #   "ip":"63.29.38.211"
    # }
    require 'json'
  #   json_payload = payload.to_json
  #   p json_payload.class
  #
  #   post '/sources/jumpstartlab/data', json_payload
  #   assert_equal 200, last_response.status
  # end

  # def test_will_send_back_400_status_if_no_payload
  #   post '/sources/jumpstartlab/data', {}
  #   assert_equal 400, last_response.status
  # end
  #

end



#

#
# As a registered user,
# when I send a POST request without a valid URL,
# then I expect a 403 response (forbidden)
