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

end
