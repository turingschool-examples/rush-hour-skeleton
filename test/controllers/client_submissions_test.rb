require_relative '../test_helper'

class ClientRegistrationTest < Minitest::Test
  include TestHelpers

  def payload
    '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    #
    # '{"url":"http://jumpstartlab.com/blog", \
    # "requestedAt":"2013-02-16 21:38:28 -0700", \
    # "respondedIn":37,"referredBy":"http://jumpstartlab.com", \
    # "requestType":"GET", \
    # "parameters":[],"eventName":"socialLogin",\
    # "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",\
    # "resolutionWidth":"1920",\
    # "resolutionHeight":"1280","ip":"63.29.38.211"}'
  end

  # def imposter_client
  #   Client.new(:root_url => params["rootUrl"], :identifier => params["identifier"])
  # end

  def test_the_client_successfully_posts_data

    post '/sources', { "rootUrl" => "http://www.google.com", "identifier" => "google" }
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"google\"}", last_response.body
    #Unsure where this undefined method error is coming from???
    post '/sources/google/data', RequestParser.parse_request(payload, "google")
    assert_equal 1, PayloadRequest.count
    assert_equal 200, last_response.status
    assert_equal "Payload Received", last_response.body
  end

  def test_missing_payload_error_response

  end





end
