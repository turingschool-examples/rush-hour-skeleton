require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_it_returns_unique_list_of_http_verbs
    create_payloads(1)

    assert_equal ["GET 0"], RequestType.list_of_verbs_used
  end

end
