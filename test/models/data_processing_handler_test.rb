require_relative '../test_helper'

class DataProcessingHandlerTest < Minitest::Test

  def test_it
    assert !!DataProcessingHandler.new('raw_payload', 'identifier')
  end

  def test_identifier_is_nil_if_not_registered
    raw_payload = {"payload"=>
                     "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
                   "splat"=>[],
                   "captures"=>["jumpstartlab"],
                   "identifier"=>"jumpstartlab"}
    identifier = 'facebook'

    handler = DataProcessingHandler.new(raw_payload, identifier)

    assert_equal nil, handler.identifier
  end
end
