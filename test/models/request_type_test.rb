require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_most_frequent_request_type
    create_payloads(3)
    assert_equal "GET", RequestType.most_frequent_request
  end

  def test_unique_Http_verbs
    create_payloads(3)
    assert_equal ["GET", "POST"], RequestType.verbs_used.sort
  end

end
