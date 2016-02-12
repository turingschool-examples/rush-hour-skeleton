require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert RequestType
  end

  # List of all HTTP verbs used
  def test_finds_all_http_verbs_used
    create_payload_1
    create_payload_2
    create_payload_3

    assert_equal ["GET", "POST"], RequestType.all_http_verbs_used
  end

end
