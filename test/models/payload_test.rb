require_relative '../test_helper'

class PayloadTest < Minitest::Test
  include TestHelpers

  def test_it_finds_the_average_response_time_across_requests
    create_payloads(2)
    assert_equal 52.0, Payload.average_response_time
  end

  def test_it_finds_max_response_time
    create_payloads(2)
    assert_equal 67.0, Payload.max_response_time
  end

  def test_it_finds_minimum_response_time
    create_payloads(2)
    assert_equal 37.0, Payload.min_response_time
  end
end
