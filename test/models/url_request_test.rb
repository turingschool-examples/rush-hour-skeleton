require_relative '../test_helper'

class UrlRequestTest < Minitest::Test
  include TestHelpers

  def test_has_attributes
    ur = UrlRequest.new

    assert_respond_to ur, :url
    assert_respond_to ur, :requestType
    assert_respond_to ur, :parameters
  end

  def test_attributes_must_be_present_when_saving
    ur = UrlRequest.new

    ur.save

    assert_equal 0, UrlRequest.all.count
  end
end
