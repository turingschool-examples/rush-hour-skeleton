require_relative '../test_helper'

class ParserTest < Minitest::Test
  include TestHelpers


  def test_it_can_parse_time
    create_payloads(1)
    request = RequestedAt.find(1)
    result = request.hour

    assert_equal 4, result
  end

end
