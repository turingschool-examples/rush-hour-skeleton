require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_has_attributes
      user_agent = UserAgent.new

      assert_respond_to user_agent, :browser
      assert_respond_to user_agent, :os
  end

  def test_attributes_must_be_present_when_saving
    user_agent = UserAgent.new

    refute user_agent.save
    refute_equal 1, UserAgent.all.size
  end
end
