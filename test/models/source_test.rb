require_relative '../test_helper'

class SourceTest < Minitest::Test

  def test_it_creates_a_source_with_valid_attributes
    attributes = {identifier: "jumpstartlab",
                  root_url: "http::/jumpstartlab.com"}
    source = Source.new(attributes)

    assert source.valid?
    source.save
    assert_equal 1, Source.count
  end

  def test_it_does_not_create_source_if_missing_attributes
    attributes = {identifier: "jumpstartlab"}
    source = Source.new(attributes)

    refute source.valid?
    source.save
    assert_equal 0, Source.count
  end

  def test_it_does_not_create_source_with_non_unique_attribute
    attributes = {identifier: "jumpstartlab",
                  root_url: "http::/jumpstartlab.com"}

    source = Source.new(attributes)
    source2 = Source.new(attributes)


    assert source.valid?
    source.save
    refute source2.valid?
    source2.save
    assert_equal 1, Source.count
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

end
