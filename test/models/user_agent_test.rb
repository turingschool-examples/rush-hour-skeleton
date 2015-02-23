require './test/test_helper'

class UserAgentTest < Minitest::Test

  def teardown
    DatabaseCleaner.clean
  end

  def test_it_correctly_parses_data
    skip
    string = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.56 Safari/536.5'
    user_agent = UserAgent.parse(string)
    assert_equal 'Chrome', user_agent.browser
    assert_equal 'Macintosh', user_agent.platform
    
    #temporary fix for this test... ruby does not like that integer for some reason
    assert_equal '19.0.1084.56', user_agent.version
  end

end