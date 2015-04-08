
require './test/test_helper'

class IdentifierTest < Minitest::Test
#don't need rack methods
  def test_it_is_not_valid_without_a_title
    id1 = Identifier.new({root_url: "http://www.jumpstartlab.com"})
    refute id1.valid?
    id1.save
    assert_equal "can't be blank", id1.errors.messages[:title].first
  end

  def test_it_is_not_valid_without_a_root_directory
    id = Identifier.new({title: "jumpstartlab"})
    refute id.valid?
    id.save
    assert_equal "can't be blank", id.errors.messages[:root_url].first
  end

  def test_it_creates_a_registration
    id3 = Identifier.new({title: "jumpstartlab", root_url: "http://jumpstartlab.com"})
    assert id3.valid?
    id3.save
  end
end
