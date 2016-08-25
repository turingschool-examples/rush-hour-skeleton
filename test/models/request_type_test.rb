require_relative '../test_helper'
require './app/models/request_type'

class RequestTypeTest < ModelTest
  def test_it_validates_input
    request_type = RequestType.new({method: "GET"})

    request_type_sad = RequestType.new({})
    assert request_type.save
    refute request_type_sad.save
  end

  def test_it_has_unique_requests
    request_type = RequestType.create({method: "GET"})
    request_type = RequestType.new({method: "GET"})

    refute request_type.save
  end

  def test_it_can_return_all_verbs_used
    request_type1 = RequestType.create({method: "GET"})
    request_type2 = RequestType.create({method: "PUSH"})
    request_type3 = RequestType.create({method: "DELETE"})

    assert_equal ["GET", "PUSH", "DELETE"], RequestType.list_all_verbs
  end
end
