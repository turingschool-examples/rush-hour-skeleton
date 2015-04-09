
require './test/test_helper'

class SourceTest < Minitest::Test
#don't need rack methods
  def test_it_is_not_valid_without_a_title
    id1 = Source.new({root_url: "http://www.jumpstartlab.com"})
    refute id1.valid?
    id1.save
    assert_equal "can't be blank", id1.errors.messages[:identifier].first
  end

  def test_it_is_not_valid_without_a_root_directory
    id = Source.new({identifier: "jumpstartlab"})
    refute id.valid?
    id.save
    assert_equal "can't be blank", id.errors.messages[:root_url].first
  end

  def test_it_creates_a_registration
    id3 = Source.new({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"})
    assert id3.valid?
    id3.save
  end
end
