require_relative '../test_helper'

class PayloadAnalyzerTest < Minitest::Test
  attr_reader :analyzer
  include TestHelpers

  def setup
    @analyzer = PayloadAnalyzer.new
    super
  end

  def test_payload_parser
    create_payloads(1)
    assert_equal "http://jumpstartlab.com/blog", Payload.all.first.url.route
    assert_equal 67, Payload.all.first.responded_in
    assert_equal "socialLogin", Payload.all.first.event_name.name
    assert_equal "1920x1280", Payload.all.first.screen_resolution.size
  end

end
