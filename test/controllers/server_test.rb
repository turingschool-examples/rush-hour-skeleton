require_relative '../test_helper'

class ServerTest < Minitest::Test
     include TestHelpers

  def test_it_can_take_in_param_and_return_200_status

    params = {"identifier" => "test", "rootUrl" => "http://test.com"}
    post '/sources', params
    assert_equal 200, last_response.status
  end



  # def test_it_accepts_a_post_to_identifier_data
  #
  #   client = Client.create(identifier: "test", root_url: "http://test.com")
  #
  #   payload = '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
  #
  #   identifier = "test"
  #
  #   param = {payload: payload, identifier: identifier}
  #
  #   post '/sources/test/data', param
  #
  #   assert_equal 200, last_response.status
  # end
end
