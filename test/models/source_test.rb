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

end
