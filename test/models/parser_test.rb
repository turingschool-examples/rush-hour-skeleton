require_relative '../test_helper'

class ParserTest < Minitest::Test
  include TestHelpers

  def test_it_can_parse_a_user_agent
    user_agent_string = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.56 Safari/536.5'
    result = Parser.parse_user_agent(user_agent_string)

    assert_equal "Chrome", result.browser
    assert_equal "Macintosh", result.platform
  end

  def test_it_can_parse_json

  end

  def test_it_can_parse_a_raw_json_payload

  end
end
