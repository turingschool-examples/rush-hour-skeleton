require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_browser_breakdown_returns_browser_with_count
    create_payloads(2)
    assert_equal ({"Mozilla 0" => 1, "Mozilla 1" => 1}), PayloadUserAgent.web_browser_breakdown
  end

  def test_platform_breakdown_returns_platform_with_count
    create_payloads(2)
    assert_equal ({"Macintosh 0" => 1, "Macintosh 1" => 1}), PayloadUserAgent.web_platform_breakdown
  end

end
