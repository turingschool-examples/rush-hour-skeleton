require_relative '../test_helper'

class ResponseTimeTest < Minitest::Test
  include TestHelper

  def test_it_can_save_a_response_time
    ResponseTime.create(time: 37)

    response_time = ResponseTime.first

    assert_equal 37, response_time.time
  end

  def test_it_can_save_a_response_time
    ResponseTime.create()

    assert_equal [], ResponseTime.all.to_a
  end

  def test_it_can_return_average_response_time_across_all_requests
    ResponseTime.create(time: 100)
    ResponseTime.create(time: 300)

    assert_equal 200, ResponseTime.avg
  end

  def test_it_can_return_max_response_time_across_all_requests
    ResponseTime.create(time: 100)
    ResponseTime.create(time: 300)

    assert_equal 300, ResponseTime.max
  end

  def test_it_can_return_min_response_time_across_all_requests
    ResponseTime.create(time: 100)
    ResponseTime.create(time: 300)

    assert_equal 100, ResponseTime.min
  end
end
