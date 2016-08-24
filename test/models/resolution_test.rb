require_relative '../test_helper'
require './app/models/resolution'

class ResolutionTest < Minitest::Test
  def test_it_validates_input
    resolution = Resolution.new({height: "100",
                                 width: "250"
                                 })

    resolution_sad = Resolution.new({height: "1000"})
    assert resolution.save
    refute resolution_sad.save
  end
end