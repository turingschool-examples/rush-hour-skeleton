require_relative '../test_helper'

class UAgentTest < Minitest::Test
  include TestHelpers

  def test_it_validates_u_agent
    u_agent = UAgent.create(agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")

    assert UAgent.all.first.valid?
    assert_equal 1, UAgent.all.count
  end

end
