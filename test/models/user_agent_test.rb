require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert UserAgent
  end

end
