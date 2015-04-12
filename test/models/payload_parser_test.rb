require './test/test_helper'

class PayloadParserTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    @pload =
    'payload={"url": "http://jumpstartlab.com/blog",
      "requestedAt"       : "2013-02-16 21:38:28 -0700",
      "respondedIn"       : 37,
      "referredBy"        : "http://jumpstartlab.com",
      "requestType"       : "GET",
      "parameters"         : [],
      "eventName"         :  "socialLogin",
      "userAgent"         : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth"   : "1920",
      "resolutionHeight"  : "1280",
      "ip"                 : "63.29.38.211"}'
  end

  def test_payload_is_not_valid_when_nil
    data = {}
    refute PayloadParser.new(data).valid?
  end

  def test_duplicate_application
    # assert_equal 0, Payload.count
    #Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    post '/sources/jadvaerbaerbllltarklab/data',  @pload
    # request1 = PayloadParser.validate({"ip" => 2, "requestedAt" => "today"}, "happy")
    # assert_equal 1, Payload.count
    assert_equal 200, request1.status

    post '/sources/jadvaerbaerbllltarklab/data',  @pload
    # request2 = PayloadParser.validate({"ip" => 2, "requestedAt" => "today"},"happy")
    # assert request2.application_duplicate?
    assert_equal 403, request2.status
    # assert request2.invalid
    # assert_equal ["Application has already been received"], request2.errors[:ip]
  end

  # def test_if_application_is_not_registered
  #   post '/sources/jadvaerbaerbllltarklab/data',
  #   assert_equal 403,
  #   assert_equal "application url does not exist", last_response.body
  # end


end
