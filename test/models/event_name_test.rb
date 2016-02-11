require_relative '../test_helper'

class EventNameTest < Minitest::Test
  include TestHelpers

  def test_it_orders_the_payloads_from_most_received_to_least
    create_payloads(4)
    assert_equal ["socialLogin", "ChickenLogin"], EventName.sort_payloads_by_requests
  end
end
