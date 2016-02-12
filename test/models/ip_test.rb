require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert Ip
  end
end
