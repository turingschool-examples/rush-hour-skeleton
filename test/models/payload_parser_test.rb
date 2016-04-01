class PayloadParserTest < Minitest::Test
  include TestHelper

  def test_if_params_are_valid_is_true
    payload = { "payload" => "url" }

    client = Client.create(identifier: "zombocom",
                           root_url:   "www.zombocom.com")

    payload_parser = PayloadParser.new

    refute payload.empty?
    assert payload_parser.valid_params?(payload, "zombocom")
  end

  def test_if_client_exists_doesnt_return_false
    payload = { "payload" => "url" }

    payload_parser = PayloadParser.new

    refute payload.empty?
    refute payload_parser.valid_params?(payload, "zombocom")
  end

  
end
