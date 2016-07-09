require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_url
    url = Url.create(address:"Turing.io")
    assert_equal "Turing.io", url.address
  end

  def test_urls_from_most_requested_to_least_requested
    create_payload(1)
    create_payload2(2)
    create_payload3(1)

    expected = ""
    assert_equal expected, Url.urls_from_most_to_least_requested
  end
end
