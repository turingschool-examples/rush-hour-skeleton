require_relative '../test_helper'
require './app/models/visitor'

class VisitorTest < Minitest::Test
  def test_it_validates_input
    visitor = Visitor.new({user_agent: "thing",
                          resolution_height: "2",
                          resolution_width: "3",
                          ip: "6"})

    visitor_sad = Visitor.new({user_agent: "thing",
                          resolution_height: "2",
                          resolution_width: "3",
                          ip: "6"})
    assert visitor.save
    refute visitor_sad.save
  end
end
