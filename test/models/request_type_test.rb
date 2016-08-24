require_relative '../test_helper'
require './app/models/request_type'

class RequestTypeTest < ModelTest
  def test_it_validates_input
    request_type = RequestType.new({request_type: "GET"})

    request_type_sad = RequestType.new({})
    assert request_type.save
    refute request_type_sad.save
  end

  def test_it_has_unique_requests
    request_type = RequestType.create({request_type: "GET"})
    request_type = RequestType.new({request_type: "GET"})

    refute request_type.save
  end
end
