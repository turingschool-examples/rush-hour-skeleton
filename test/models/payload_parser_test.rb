require './test/test_helper'

class PayloadParserTest < Minitest::Test

  def test_payload_is_not_valid_when_nil
    data = {}
    payload = PayloadParser.new(data)
    assert_equal 400, payload.valid?
  end

  def test_payload_parses_into_hash_of_symbols_and_snake_case
    var = PayloadParser.new.parse_payload({payload: '{"respondedAt": "boo", "respondedIn": 37}'})
    assert_equal :responded_at, var.keys.first
  end
end
    # we're taking in the payload request information
    # we're sending that to the JSON.parse method
    # before the JSON.parse method is called, we want to make sure the info is valid
    # it can't be nil or an empty hash
