require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert RequestType
  end

  def test_can_create_request_types_through_payload_request
    pr = create_payload_1

    assert_equal "GET", RequestType.find(1).verb
    assert_equal 1, pr.request_type_id
  end

  def test_can_create_request_types
    req_type = {verb: "GET"}
    rt = RequestType.create(req_type)

    assert_equal "GET", rt.verb
    assert_equal 1, RequestType.all.count
  end

  def test_same_request_type_will_not_be_added_to_database
    req_type = {verb: "GET"}
    rt = RequestType.create(req_type)

    assert_equal 1, RequestType.all.count

    req_type2 = {verb: "GET"}
    rt2 = RequestType.create(req_type2)

    refute rt2.valid?
    assert rt2.id.nil?
    assert_equal 1, RequestType.all.count
  end

  def test_finds_all_http_verbs_used
    create_payload_1
    create_payload_2
    create_payload_3
    create_payload_4
    create_payload_5

    assert_equal ["GET", "POST", "PUT"], RequestType.all_http_verbs_used.sort
  end

end
