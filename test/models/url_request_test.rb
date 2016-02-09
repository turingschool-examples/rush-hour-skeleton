require_relative '../test_helper'

class UrlRequestTest < Minitest::Test
  include TestHelpers

  def test_has_attributes
    ur = UrlRequest.new

    assert_respond_to ur, :url
    assert_respond_to ur, :requestType
    assert_respond_to ur, :parameters
  end
end
