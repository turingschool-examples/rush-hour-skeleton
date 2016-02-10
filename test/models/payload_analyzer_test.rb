require_relative '../test_helper'

class PayloadAnalyzerTest < Minitest::Test
  include TestHelpers

  def test_payload_parser
    parser = PayloadAnalyzer.new
    parsed_payload = parser.parse(random_payload)
    assert_equal "http://jumpstartlab.com/about", Payload.all.first.url.kind
  end


end
