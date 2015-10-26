require './test/test_helper'

class SourceCreatorTest < Minitest::Test
  def test_can_create_a_source
    create_sources(1)
    source = TrafficSpy::Source

    assert_equal 1, source.count
  end
end
