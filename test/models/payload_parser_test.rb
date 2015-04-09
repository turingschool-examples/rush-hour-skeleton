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

  def test_duplicate_application
    #assert_equal 0, Payload.count
    request1 = PayloadParser.validate({"ip" => 2, "requestedAt" => "today"})
    # assert_equal 1, Payload.count
    assert_equal 200, request1.status

    request2 = PayloadParser.validate({"ip" => 2, "requestedAt" => "today"})
    assert request2.application_duplicate?
    assert_equal 400, request2.status
    # assert request2.invalid
    # assert_equal ["Application has already been received"], request2.errors[:ip]
  end


end
