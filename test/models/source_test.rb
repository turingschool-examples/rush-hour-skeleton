require_relative '../test_helper'

class SourceTest < Minitest::Test
  def test_valid_with_identifier_and_root_url
    source = Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    assert_equal "jumpstartlab", source.identifier
    assert_equal "http://jumpstartlab.com", source.root_url
    assert source.valid?
  end

  def test_valid_uniqueness_of_identifier
    source_one = Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    source_two = Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    assert source_one.valid?
    refute source_two.valid?
    assert_equal 1, Source.count
  end

  def test_invalid_without_identifier
    source = Source.create(root_url: "http://jumpstartlab.com")
    refute source.valid?
  end

  def test_invalid_without_root_url
    source = Source.create(identifier: "jumpstartlab")
    refute source.valid?
  end
end
