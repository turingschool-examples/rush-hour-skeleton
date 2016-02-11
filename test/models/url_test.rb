require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert Url
  end

end
