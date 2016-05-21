require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_browser_breakdown_returns_browser_with_count
    create_payloads(2)

    assert_equal ({"socialLogin 1" => 1, "socialLogin 0" => 1}), EventName.events_breakdown
  end

end
