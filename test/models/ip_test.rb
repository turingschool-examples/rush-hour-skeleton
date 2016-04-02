require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers

  def test_it_can_accept_ip
    ip = Ip.create(address: "socialLogin")

    assert_equal "socialLogin", ip.address
  end

  def test_it_checks_for_empty_name
    ip = Ip.create(address: nil)

    assert_nil ip.address
  end

  def test_it_responds_with_an_error_message
    ip = Ip.create(address: nil)

    assert_equal "can't be blank", ip.errors.messages[:address][0]
  end
end
