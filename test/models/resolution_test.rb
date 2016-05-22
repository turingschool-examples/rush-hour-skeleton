require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_resolution_breakdown_returns_resolution_with_count
    create_payloads(2)

    assert_equal ({"1280 0 x 1920 0" => 1, "1280 1 x 1920 1" => 1}), Resolution.resolutions_breakdown
  end


end
