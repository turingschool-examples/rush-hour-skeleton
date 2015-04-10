require './test/test_helper'

class PayloadParserTest < Minitest::Test

  def test_payload_is_not_valid_when_nil
    data = {}
    refute PayloadParser.new(data).valid?
  end

  # def test_payload_parses_into_hash_of_symbols_and_snake_case
  #   var = PayloadParser.new.parse({payload: '{"respondedAt": "boo", "respondedIn": 37}'})
  #   assert_equal :responded_at, var.keys.first
  # end
  def test_payload_is_not_valid_when_application_is_not_registered

  end

  def test_duplicate_application
    #assert_equal 0, Payload.count
    request1 = PayloadParser.validate({"ip" => 2, "requestedAt" => "today"})
    # assert_equal 1, Payload.count
    assert_equal 200, request1.status

    request2 = PayloadParser.validate({"ip" => 2, "requestedAt" => "today"})
    assert request2.application_duplicate?
    assert_equal 403, request2.status
    # assert request2.invalid
    # assert_equal ["Application has already been received"], request2.errors[:ip]
  end
#pasted
  def test_payload_returns_200_when_request_is_unique
    skip
#    post '/sources', {"identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" )
    post '/sources/jumpstartlab/data', @pload
    assert_equal 200, last_response.status
    assert_equal "Success", last_response.body
    payload = Payload.last
    assert_equal "http://jumpstartlab.com/blog", payload.url
  end

  def test_response_when_identifier_doesnt_exist
    skip
    post '/sources/jadvaerbaerbllltarklab/data', @pload
    assert_equal 403, last_response.status
    assert_equal "application url does not exist", last_response.body
  end



end
