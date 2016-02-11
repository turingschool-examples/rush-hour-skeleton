require_relative '../test_helper'

class UserSystemTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert UserSystem
  end

end
