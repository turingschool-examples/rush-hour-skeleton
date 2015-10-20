require './test/test_helper'

class SourceCreatorTest < Minitest::Test
  def test_can_create_a_source
    source = TrafficSpy::Source
    source.create({identifier: "jumpstartlab",
                               root_url: "http://jumpstartlab.com"
                  })

    assert_equal 1, source.count
  end
end
