require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_accept_url
    url = Url.create(address: "www.turing.io")

    assert_equal "www.turing.io", url.address
  end

  def test_it_checks_for_empty_address
    url = Url.create(address: nil)

    assert_nil url.address
  end

  def test_it_responds_with_an_error_message
    url = Url.create(address: nil)

    assert_equal "can't be blank", url.errors.messages[:address][0]
  end
end
