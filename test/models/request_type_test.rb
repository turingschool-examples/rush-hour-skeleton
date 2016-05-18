require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers
  attr_reader :payload, :url, :referrer, :request_type, :event_name,
              :user_agent, :resolution, :ip

  def test_it_returns_unique_list_of_http_verbs
    assert_equal ["GET"], RequestType.list_of_verbs_used
  end

end
