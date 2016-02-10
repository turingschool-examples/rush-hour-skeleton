require_relative '../test_helper'

class PayloadAnalyzerTest < Minitest::Test
  attr_reader :analyzer
  include TestHelpers

  def setup
    @analyzer = PayloadAnalyzer.new
    super
  end

  def test_payload_parser
    analyzer.parse(random_payloads.first)
    assert_equal "http://jumpstartlab.com/about", Payload.all.first.url.route
    assert_equal 67, Payload.all.first.responded_in
    assert_equal "socialLogin", Payload.all.first.event_name.name
  end

  def test_it_finds_the_average_response_time_across_requests
    random_payloads.each { |payload| analyzer.parse(payload) }
    assert_equal 52.0, analyzer.average_response_time
  end

  def test_it_finds_max_response_time
    random_payloads.each { |payload| analyzer.parse(payload) }
    assert_equal 67.0, analyzer.max_response_time
  end

end
