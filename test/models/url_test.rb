require_relative '../test_helper'

class UrlTest < Minitest::Test

    def test_url_has_many_payloads
      url = Url.new
      assert_equal [], url.payloads
    end

end
