require_relative '../test_helper'
require 'json'

class CreateGenreTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def test_can_create_a_payload_with_valid_attributes
    post '/sources', {"identifier" => "jumpstartlab", "rootUrl"=>"http://jumpstartlab.com/"}

    params_to_json = {"url":"http://jumpstartlab.com/","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}.to_json
    post '/sources/jumpstartlab/data', "payload=#{params_to_json}"

    assert_equal 1, PayloadRequest.count
    assert_equal 200, last_response.status
    assert_equal "Payload created", last_response.body
  end

end
