require_relative '../test_helper'
require './app/models/request_type'

class IpTest < Minitest::Test
  def test_it_validates_input
    request_type = RequestType.new({request_type: "GET"})

    request_type_sad = RequestType.new({})
    assert request_type.save
    refute request_type_sad.save
  end
end