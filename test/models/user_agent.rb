require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_has_attributes
      user_agent = UserAgent.new

      assert_respond_to user_agent, :browser
      assert_respond_to user_agent, :os
  end

  
