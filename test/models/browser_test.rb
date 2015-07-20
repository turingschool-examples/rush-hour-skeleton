require_relative '../test_helper'

class BrowserTest < Minitest::Test

    def test_browser_has_many_payloads
      browser = Browser.new
      assert_equal [], browser.payloads
    end

end
