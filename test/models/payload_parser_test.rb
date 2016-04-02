class PayloadParserTest < Minitest::Test
  include TestHelper

  def test_if_params_are_valid_is_true
    payload = { "payload" => "url" }

    client = Client.create(identifier: "zombocom",
                           root_url:   "www.zombocom.com")

    payload_parser = PayloadParser.new

    refute payload.empty?
    assert payload_parser.params_are_valid?(payload, "zombocom")
  end

  def test_if_client_exists_doesnt_return_false
    payload = { "payload" => "url" }

    payload_parser = PayloadParser.new

    refute payload.empty?
    refute payload_parser.params_are_valid?(payload, "zombocom")
  end

  def test_if_payload_is_nil_and_client_exists_returns_false
    payload = { "payload" => nil }

    payload_parser = PayloadParser.new

    assert payload["payload"].nil?
    refute payload_parser.params_are_valid?(payload, "zombocom")
  end

  def test_that_json_parses_params_to_hash
    params = { "payload" => "{\"url\":\"http://www.zombo.com/\"}" }

    payload_parser = PayloadParser.new

    hash =  { "url" => "http://www.zombo.com/"}
    assert_equal hash, payload_parser.parse_json(params)
  end
end
