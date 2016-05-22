require_relative '../test_helper'

class RespondedInTest < Minitest::Test
  include TestHelpers

  def test_it_finds_average_response_time
    create_payloads(3)

    assert_equal 1, RespondedIn.average_response_time
  end

  def test_it_finds_max_response_time
    create_payloads(3)

    assert_equal 2, RespondedIn.max_response_time
  end

  def test_it_finds_min_response_time
    create_payloads(3)

    assert_equal 0, RespondedIn.min_response_time
  end
end
