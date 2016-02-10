require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_url_can_instantiate_with_address
    ur = Url.new(address: "http://www.kazookid.com")
    assert ur.valid?
  end

  def test_url_needs_address_to_instantiate
    ur = Url.new()
    refute ur.valid?
  end

  def test_url_has_an_address
    ur = Url.create(address: "http://www.kazookid.com")
    assert_equal "http://www.kazookid.com", Url.all.first.address
  end


  def test_url_has_payload_requests
    ur = Url.new(address: "http://www.kazookid.com")
    assert_respond_to ur, :payload_requests
  end
end
